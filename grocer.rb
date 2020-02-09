def find_item_by_name_in_collection(name, collection)
  i = 0 
  
  while i < collection.length do 
    if name == collection[i][:item]
      return collection[i]
    end
    i+=1 
  end 
  nil 
end



  
  def consolidate_cart(cartt) 
    array = cartt.uniq 
    i = 0 
    while i < array.length 
        array[i][:count] = 0 
        i+=1 
    end
    j = 0 
    while j < array.length do 
        k = 0 
        while k < cartt.length do 
            if array[j][:item] == cartt[k][:item]
                array[j][:count]+=1 
            end
            k+=1 
        end 
        j+=1 
    end
    
    return array 
  end 



 def apply_coupons(cart, coupons)
  new_cart = []
  i = 0
    # go through each item of the cart 
  while i < cart.length do 
    # go through each coupon 
    j = 0 
    while j < coupons.length do 
      # check if any coupons match the name of the cart item 
      if coupons[j][:item] == cart[i][:item] 
          # if a coupon does, make sure the cart has enough of that item
        if cart[i][:count] >= coupons[j][:num]
          # if it is, subtract the num for the coupon from that item's count 
          cart[i][:count] -= coupons[j][:num]
          # then make a new item, with the same attributes, but price = coupon price, count = coupon num, and name = item name +" W/COUPON"
          new_cart << {item:cart[i][:item] + " W/COUPON",price:(coupons[j][:cost]/coupons[j][:num]),count:coupons[j][:num],clearance:cart[i][:clearance]}
        end
      end
    
      j+=1 
    end
    i+=1 
  end 
  # REMEMBER: This method **should** update cart
  cart = cart+new_cart
  return cart 
end

def apply_clearance(cart)
  
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance]
      cart[i][:price] = cart[i][:price]*0.8 
      cart[i][:price] = cart[i][:price].round(2)
    end 
    i+=1 
  end
  return cart
end


def checkout(cart, coupons)
  
  cart = consolidate_cart(cart) 
  # p 'cart after consolidate_cart method in checkout method'
  # pp cart 
  cart = apply_coupons(cart,coupons) 
  cart = apply_clearance(cart) 
  
  # pp array 
  
  
  grand_total = 0 
  i = 0 
  while i < cart.length do 
    grand_total += cart[i][:price]*cart[i][:count]
    i+=1 
  end
  if grand_total > 100 
    grand_total *=0.9
  end
  return grand_total
  
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end