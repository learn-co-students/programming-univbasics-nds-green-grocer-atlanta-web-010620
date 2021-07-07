def find_item_by_name_in_collection(name, collection)
 items = {}
 i = 0
 while i < collection.length
 items[collection[i][:item]] = collection[i]
 i += 1
 end
 return items[name]
end

def consolidate_cart(cart)
 full_cart = []
  i = 0
  while i < cart.length
  full_cart_item = find_item_by_name_in_collection(cart[i][:item], full_cart)
  if full_cart_item != nil
    full_cart_item[:count] += 1
  else 
    full_cart_item = {
    :item => cart[i][:item],
    :price => cart[i][:price],
    :clearance => cart[i][:clearance],
    :count => 1
  }
  full_cart << full_cart_item
end
i += 1
end
return full_cart
end
def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  i = 0
  while i < cart.length
  j = 0
  while j < coupons.length
  if cart[i][:item] == coupons[j][:item] && cart[i][:count] >= coupons[j][:num]
    cart[i][:count] = cart[i][:count] - coupons[j][:num]
    cart << {:item => "#{cart[i][:item]} W/COUPON", 
    :price => coupons[j][:cost] / coupons[j][:num], 
    :clearance => cart[i][:clearance],
    :count => coupons[j][:num]
    }
  end
  j += 1
end
i += 1
end
  return cart
end

def apply_clearance(cart)
  i = 0
  while i < cart.length
  if cart[i][:clearance]
    cart[i][:price] = (cart[i][:price] * 0.8).round(2)
    end
    i += 1
end
  return cart
end

def checkout(cart, coupons)
 new_cart = consolidate_cart(cart)
 middle_cart = apply_coupons(new_cart, coupons)
 last_cart = apply_clearance(middle_cart)
 puts last_cart
 total = 0
 i = 0
 while i < last_cart.length
 total += last_cart[i][:price] * last_cart[i][:count]
 i += 1
 end
 
 if total > 100
   total *= 0.9
 end
  return total
end
