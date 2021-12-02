# frozen_string_literal: true

class Api::AnalysesController < ApplicationController
  before_action :validate_params_presence, only: [:create]
  before_action :analyze_resource, only: [:create]

  def create
    analysis =
      Analysis.create(
        analysis_params.merge!(
          results: @results,
          request_ip: request.remote_ip
        )
      )
    if analysis.persisted?
      render json: analysis
    else
      render json: analysis.errors.full_messages, status: 422
    end
  end

  private

  def analysis_params
    params.require(:analysis).permit!
  end

  def analyze_resource
    resource = analysis_params[:resource]
    if analysis_category == :image
      @results = image_analysis(resource)
    elsif analysis_category == :text
      @results = text_analysis(resource)
    end
  end

  def text_analysis(text)
    model_id = 'cl_KFXhoTdt' # Profanity & Abuse Detection
    response = Monkeylearn.classifiers.classify(model_id, [text])
    response.body[0]
  end

  def image_analysis(url)
    Clarifai::Rails::Detector.new(url).image.concepts_with_percent
  rescue RestClient::BadRequest => e
    render json: {
      message: 'Invalid image URL'
    }, status: 422
  end

  def analysis_category
    analysis_params[:category].to_sym
  end

  def validate_params_presence
    if params[:analysis].nil?
      render json: {
        message: 'Missing category and resource params'
      },
             status: 422
    elsif params[:analysis][:category].nil?
      render json: { message: 'Missing category param' }, status: 422
    elsif params[:analysis][:resource].nil?
      render json: { message: 'Missing resource param' }, status: 422
    end
  end
end
