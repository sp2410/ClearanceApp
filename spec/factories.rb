FactoryGirl.define do
  factory :user do  

    sequence(:email) do |n| 
      "myname#{n}@gmail.com" 
    end

    password "123abc"
    password_confirmation "123abc"
      factory :admin do 
        role "admin"
      end
      factory :staff do 
        role "staff"
      end
      factory :vendor do 
        role "vendor"
      end
    
  end

  factory :clearance_batch do    
    
  end

  factory :item do    
    color "Blue"
    size "M"    
    price_sold "23"
    status "sold" 

    style    

  end

  factory :style do        
    type "Sweater"
    name "Abrianna Lightweight Knit Cardigan"
    wholesale_price "10" 
    retail_price "60"
    
  end



end
