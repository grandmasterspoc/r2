class TranslationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  def index
    @translators = Translation.all
  end

  def show
    @translator = Translation.find(params[:id])
    @translator.translation(@translator.original_text)
    redirect_to translations_path
  end

  def new
    @translator = Translation.new
  end

  def create
    @translator = Translation.new(word_params)
    if @translator.save
      @translator.translation(@translator.original_text)
      redirect_to new_translation_path
    else
      render :new
    end
  end   

  def destroy
  end

  private
  def word_params
    params.require(:translation).permit(:original_text, :user_id)
  end  

end
