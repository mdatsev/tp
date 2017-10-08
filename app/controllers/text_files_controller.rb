require 'csv'
require 'linear-regression'

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
    #csv array
    arr = CSV.parse(@text_file.content, converters: :numeric);    

    #i
    @sumX = arr.inject(0) {|sum, n| sum + n[0] };

    #ii
    @sumY = arr.inject(0) {|sum, n| sum + (!n[2].nil? ? (n[2] % 2 == 1 ? n[1] : 0) : 0)};

    #iii
    incomes = arr.map { |n| n[0] };
    @max_sum = incomes[0..29].inject(0, :+);
    max_sum_index = 0;
    for i in 0.. incomes.length - 30
      sum = 0;
      for j in 0..29
        sum += incomes[i+j];
      end
      if @max_sum < sum
        @max_sum = sum; 
        max_sum_index = i;  
      end 
    end
    @days = incomes[max_sum_index..max_sum_index + 29]

    #iv
    xs = (1..arr.length).to_a;
    ys =  arr.map { |n| n[0] };
    linear = Regression::Linear.new(xs, ys);
    @next = linear.predict(arr.length + 1);
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
