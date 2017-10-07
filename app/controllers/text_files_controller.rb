class TextFilesController < ApplicationController
  before_action :set_text_file, only: [:show, :edit, :update, :destroy]

  # GET /text_files
  # GET /text_files.json
  def index
    @text_files = TextFile.all
  end

  # GET /text_files/1
  # GET /text_files/1.json
  def show
  end

  # GET /text_files/new
  def new
    @text_file = TextFile.new
  end

  # GET /text_files/1/edit
  def edit
  end

  # POST /text_files
  # POST /text_files.json
  def create
    @text_file = TextFile.new(text_file_params)

    respond_to do |format|
      if @text_file.save
        format.html { redirect_to @text_file, notice: 'Text file was successfully created.' }
        format.json { render :show, status: :created, location: @text_file }
      else
        format.html { render :new }
        format.json { render json: @text_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /text_files/1
  # PATCH/PUT /text_files/1.json
  def update
    respond_to do |format|
      if @text_file.update(text_file_params)
        format.html { redirect_to @text_file, notice: 'Text file was successfully updated.' }
        format.json { render :show, status: :ok, location: @text_file }
      else
        format.html { render :edit }
        format.json { render json: @text_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_files/1
  # DELETE /text_files/1.json
  def destroy
    @text_file.destroy
    respond_to do |format|
      format.html { redirect_to text_files_url, notice: 'Text file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text_file
      @text_file = TextFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_file_params
      params.require(:text_file).permit(:name, :content)
    end
end
