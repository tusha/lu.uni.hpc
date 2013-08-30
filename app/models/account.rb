class Account < ActiveRecord::Base
  belongs_to :user
  attr_accessor :script
 
   require 'fileutils'
   require "coderay"
   
   
  
  def self.save_file(params)  
    directory=Rails.root.join('public/uploads', params[:user_id], 'job','job_id')
    path=File.join(directory,params[:script].original_filename)    
    script_url="public/uploads/"+params[:user_id]+'/job/'+'job_id/'+params[:script].original_filename
    
    dir = File.dirname(path)
    unless File.directory?(dir)
    FileUtils.mkdir_p(dir)
    end  
    data= CodeRay.scan(params[:script].read, :javascript).html(
     :wrap => :div,
     :line_numbers => :inline,
     :break_lines => :true,
     :css => :style)   
    File.open(path, 'wb'){|f| f.write(data)}
  return script_url
  end 
  
  def self.destoy_file(account)
    directory=Rails.root.join(account.script_url)
    File.delete(directory)    
  end
  
   def self.add_user_tokens(user_id, token_id, amount)
     account=Account.find_by_user_id(user_id)   
     flag=true 
      if account.tokens != nil
         account.tokens.each do |t|
          if t[0].to_i== token_id.to_i
            ind=account.tokens.index(t)
            val=t[1].to_i + amount.to_i
            account.tokens.delete_at(ind)
            account.tokens << [token_id, val]
            flag=false
          end               
        end  
       if flag
         account.tokens.push([token_id, amount])  
       end
      account.tokens_will_change!
      account.save
    end
   end
  
 

  

  
end
