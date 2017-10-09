class SumController < ApplicationController
    def form
    end
    ColX = 0;    
    def calc
        if(params.has_key?("file"))
            recieved_file = params["file"];
            @text_file = TextFile.new({name: recieved_file.original_filename, content: recieved_file.read})
        else
            @text_file = TextFile.new(text_file_params)
        end
        arr = CSV.parse(@text_file.content, converters: :numeric);  
        render plain: ((arr.inject(0) {|sum, n| sum + n[ColX] }).ceil.to_s + ",00").html_safe;
    end
end
