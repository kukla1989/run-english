
class ArticlesController < ApplicationController
  include ESpeak
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def run_english
    @article = Article.find(params[:id])
    @navigation = params[:navigation].to_i
    @navigation = 0 if @navigation < 0  #protec from go out of collection @article.sentences
    @navigation = @article.sentences.size * 2 - 1 if @navigation >= @article.sentences.size * 2
    if @navigation % 2 == 1  #if true english sentence
      @speech = ESpeak::Speech.new(@article.sentences[@navigation / 2].sentence_eng, voice: "en-us", pitch: 65, speed: 130)
      @sentence = @article.sentences[@navigation / 2].sentence_eng
    elsif
      @speech = ESpeak::Speech.new(@article.sentences[@navigation / 2].sentence_ru, voice: "ru", pitch: 65, speed: 130)
      @sentence = @article.sentences[@navigation / 2].sentence_ru
    end
  end

  def new
    @article = Article.new
  end


def create
    @article = Article.new(article_params)
    if @article.save
      eng_sentences = @article.body.split('.')
      ru_sentences = @article.body_ru.split('.')
      eng_sentences.size.times do|i|
        Sentence.new(sentence_eng: eng_sentences[i], sentence_ru: ru_sentences[i], article_id: @article.id).save
      end


      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end



private
  def article_params
    params.require(:article).permit(:title, :body, :body_ru)
  end

  
end