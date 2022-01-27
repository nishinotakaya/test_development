class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy, :edit]
  before_action :authenticate_user!
  protect_from_forgery :except => [:destroy]
  #index->データの一覧の表示
  def index
    #articleのデータの全件取得
    @articles = current_user.articles
  end

  def new
    @article = current_user.articles.new
  end

  def show
  #before_actionでデータの取得は完了している
  end

  #create->新規データの登録
  def create
    #formのデータを受け取る
    @article = current_user.articles.new(article_params)
    if @article.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to articles_url
    else
    #saveを失敗すると新規作成ページへ
      render :new
    end
  end

  #edit->編集ページの表示
  def edit
  #before_actionでデータの取得は完了している
  end

  def update
    #編集データの取得
    if @article.update_attributes(article_params)
      #updateが完了したら一覧ページへリダイレクト
      flash[:success] = "従業員情報を更新しました。"
      redirect_to articles_url
    else
      #updateを失敗すると編集ページへ
      render :edit     
    end
  end

  #destroy->データの削除
  def destroy
    #データの削除
    @article.destroy
    flash[:success] = "#{@article.title}のデータを削除しました。"
    #一覧ページへリダイレクト
    redirect_to articles_url
  end



  private

    def article_params
      params.require(:article).permit(:title, :content, :image).merge(user_id: current_user.id)
    end

    #共通処理なので、before_actionで呼び出している
    def set_article
    #特定データの取得
      @article = current_user.articles.find(params[:id])
    end
end
