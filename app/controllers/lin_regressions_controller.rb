class LinRegressionsController < ApplicationController
    Incomes_col = 0;
    ColX = 0;    
    def calc
        if(params.has_key?("file"))
            recieved_file = params["file"];
            @text_file = TextFile.new({name: recieved_file.original_filename, content: recieved_file.read})
        else
            @text_file = TextFile.new(text_file_params)
        end
        arr = CSV.parse(@text_file.content, converters: :numeric);  
        xs = (1..arr.length).to_a;
        ys =  arr.map { |n| n[Incomes_col] };
        linear = Regression::Linear.new(xs, ys);
        a = linear.slope;
        b = linear.intercept;
        render plain: ('%.6f' % a + "," + '%.6f' %  b).html_safe;        
    end
end
