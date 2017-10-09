class IntervalsController < ApplicationController
    def form
    end
    Incomes_col = 0;
    Succ_days = 30;
    def calc
      if(params.has_key?("file"))
        recieved_file = params["file"];
        @text_file = TextFile.new({name: recieved_file.original_filename, content: recieved_file.read})
       else
        @text_file = TextFile.new(text_file_params)
      end
      arr = CSV.parse(@text_file.content, converters: :numeric);          
        incomes = arr.map { |n| n[Incomes_col] };
        @max_sum = incomes[0..Succ_days-1].inject(0, :+);
        max_sum_index = 0;
        for i in 0.. incomes.length - Succ_days
          sum = 0;
          for j in 0..Succ_days-1
            sum += incomes[i+j];
          end
          if @max_sum < sum
            @max_sum = sum; 
            max_sum_index = i;  
          end 
        end
    render plain: (@max_sum.ceil.to_i.to_s + ",00").html_safe;        
    end
end
