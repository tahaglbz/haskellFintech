{-# OPTIONS_GHC -Wno-name-shadowing #-}

module UserManagement (displaySortedCustomers, Customer, customers, getCustomerAges, getCustomerBalances, displayRiskManagement, getRiskNotes, displaySortedCustomersByBalance) where

import Data.List (sortBy)

data Customer = Customer
  { customerId :: Int,
    firstName :: String,
    lastName :: String,
    age :: Int,
    email :: String,
    balance :: Float,
    riskNote :: String
  }
  deriving (Show)

customers :: [Customer]
customers =
  [ Customer 1 "Charlotte" "White" 56 "Isabella@hotmail.com" 5645.416 "Medium",
    Customer 2 "Alexander" "Miller" 19 "Sarah@example.com" 9595.98 "Low",
    Customer 3 "John" "Moore" 31 "Michael@hotmail.com" 2777.1067 "Low",
    Customer 4 "James" "Moore" 47 "Ava@hotmail.com" 5131.16 "High",
    Customer 5 "Michael" "Miller" 51 "Henry@example.com" 2424.3093 "Low",
    Customer 6 "Daniel" "Brown" 48 "John@gmail.com" 3920.3447 "High",
    Customer 7 "Charlotte" "Johnson" 76 "Charlotte@gmail.com" 7163.904 "High",
    Customer 8 "John" "Taylor" 38 "Charlotte@hotmail.com" 9255.023 "Low",
    Customer 9 "Henry" "Williams" 41 "Daniel@example.com" 8214.321 "High",
    Customer 10 "Isabella" "Anderson" 25 "Sophia@yahoo.com" 7254.7734 "Medium",
    Customer 11 "Emily" "Garcia" 53 "James@example.com" 6636.7905 "High",
    Customer 12 "Isabella" "Taylor" 35 "Michael@hotmail.com" 7096.4443 "Low",
    Customer 13 "Bob" "Anderson" 36 "Bob@hotmail.com" 7327.109 "Medium",
    Customer 14 "Charlotte" "Martin" 19 "Sarah@gmail.com" 1303.2329 "High",
    Customer 15 "Bob" "Wilson" 28 "James@yahoo.com" 8602.504 "Medium",
    Customer 16 "Emma" "Taylor" 39 "William@hotmail.com" 7789.5166 "High",
    Customer 17 "Alice" "Harris" 55 "Emma@yahoo.com" 2746.0903 "High",
    Customer 18 "Alice" "Robinson" 56 "Sophia@gmail.com" 420.4464 "Low",
    Customer 19 "Samuel" "Taylor" 61 "David@example.com" 3321.7651 "Medium",
    Customer 20 "Isabella" "Garcia" 61 "William@gmail.com" 3726.8008 "Medium",
    Customer 21 "William" "Martinez" 62 "James@hotmail.com" 380.80035 "High",
    Customer 22 "David" "White" 71 "Emily@hotmail.com" 3137.9282 "Medium",
    Customer 23 "Ava" "Moore" 50 "Alice@gmail.com" 1681.5251 "Low",
    Customer 24 "Bob" "Williams" 65 "Bob@hotmail.com" 1566.3726 "Medium",
    Customer 25 "Emily" "Jones" 34 "Michael@yahoo.com" 2374.4482 "High",
    Customer 26 "Michael" "Moore" 62 "Sarah@hotmail.com" 5677.377 "High",
    Customer 27 "Grace" "Smith" 53 "Michael@gmail.com" 6523.1777 "Medium",
    Customer 28 "Isabella" "Robinson" 64 "William@gmail.com" 2710.2988 "Medium",
    Customer 29 "Sarah" "Brown" 80 "Charlotte@yahoo.com" 8601.919 "Medium",
    Customer 30 "Emma" "Harris" 18 "Isabella@yahoo.com" 8589.782 "High",
    Customer 31 "William" "Jackson" 54 "Emma@yahoo.com" 2782.4365 "Low",
    Customer 32 "Emma" "Jackson" 72 "Emily@example.com" 9318.912 "High",
    Customer 33 "Alexander" "Wilson" 41 "Samuel@yahoo.com" 4518.5195 "Low",
    Customer 34 "Sophia" "Martinez" 59 "James@yahoo.com" 727.3048 "High",
    Customer 35 "Daniel" "Garcia" 22 "William@example.com" 764.0153 "Medium",
    Customer 36 "Alice" "Davis" 25 "Isabella@yahoo.com" 1304.655 "Medium",
    Customer 37 "Emily" "Miller" 57 "Henry@example.com" 9949.917 "Medium",
    Customer 38 "Bob" "Brown" 56 "David@gmail.com" 6759.56 "High",
    Customer 39 "Charlotte" "Martin" 24 "Willian@example.com" 8171.1816 "Low",
    Customer 40 "Olivia" "Johnson" 59 "Samuel@example.com" 126.91796 "High",
    Customer 41 "Alexander" "Robinson" 53 "Isabella@gmail.com" 9319.851 "High",
    Customer 42 "Sarah" "Anderson" 18 "Grace@example.com" 8808.455 "High",
    Customer 43 "Olivia" "Garcia" 74 "Sarah@hotmail.com" 9523.738 "Low",
    Customer 44 "Michael" "Harris" 58 "Olivia@gmail.com" 4076.9421 "Medium",
    Customer 45 "Ava" "Davis" 35 "John@Example.com" 7000.258 "Low",
    Customer 46 "Henry" "Harris" 55 "Sophia@gmail.com" 1696.0818 "Medium",
    Customer 47 "James" "Moore" 29 "Ava@hotmail.com" 5799.3555 "Medium",
    Customer 48 "James" "Harris" 64 "Emily@example.com" 4584.204 "Medium",
    Customer 49 "Ava" "Martin" 74 "Sophia@hotmail.com" 2957.5198 "High",
    Customer 50 "Willian" "Anderson" 63 "David@example.com" 6662.1543 "Medium",
    Customer 51 "John" "Anderson" 41 "Alexander@yahoo.com" 1272.8464 "Medium",
    Customer 52 "Charlotte" "Jackson" 38 "Henry@gmail.com" 2197.9785 "Low",
    Customer 53 "Michael" "White" 46 "Sarah@hotmail.com" 553.6741 "High",
    Customer 54 "John" "Johnson" 35 "Ava@example.com" 7307.3506 "High",
    Customer 55 "John" "Taylor" 56 "Michael@yahoo.com" 2978.2236 "Low",
    Customer 56 "James" "Anderson" 30 "Emma@hotmail.com" 7330.0693 "Low",
    Customer 57 "Sarah" "Thompson" 32 "Ava@example.com" 4946.1753 "Medium",
    Customer 58 "Ava" "Taylor" 28 "Sophia@example.com" 3277.7732 "High",
    Customer 59 "Henry" "Robinson" 64 "Samuel@gmail.com" 2879.451 "Medium",
    Customer 60 "Charlotte" "Jones" 45 "Ava@example.com" 9548.86 "High",
    Customer 61 "David" "Taylor" 37 "Isabella@yahoo.com" 9255.629 "High",
    Customer 62 "Henry" "Wilson" 33 "Ava@hotmail.com" 4245.8447 "Low",
    Customer 63 "Emma" "Smith" 70 "Michael@yahoo.com" 1304.0483 "Medium",
    Customer 64 "David" "Davis" 71 "Sarah@hotmail.com" 7300.1694 "Medium",
    Customer 65 "Willian" "Garcia" 18 "Alexander@yahoo.com" 9448.608 "Medium",
    Customer 66 "Alice" "Brown" 19 "Sophia@hotmail.com" 2117.0313 "Low",
    Customer 67 "Ava" "Garcia" 51 "David@example.com" 8550.949 "Low",
    Customer 68 "Ava" "Johnson" 27 "Sophia@hotmail.com" 2176.4421 "Medium",
    Customer 69 "Emily" "Garcia" 36 "Michael@gmail.com" 482.62717 "Medium",
    Customer 70 "Emily" "Smith" 80 "Olivia@gmail.com" 4615.12 "Medium",
    Customer 71 "Alice" "Brown" 44 "Willian@example.com" 6016.9575 "Medium",
    Customer 72 "Charlotte" "Anderson" 47 "John@example.com" 1133.281 "High",
    Customer 73 "James" "White" 76 "James@hotmail.com" 6529.9346 "Low",
    Customer 74 "Emma" "Harris" 31 "Henry@hotmail.com" 5893.419 "Medium",
    Customer 75 "Samuel" "Martinez" 79 "Bob@gmail.com" 958.6728 "High",
    Customer 76 "Henry" "Taylor" 44 "Alice@hotmail.com" 7389.742 "Medium",
    Customer 77 "Ava" "Miller" 25 "Ava@gmail.com" 7863.218 "Low",
    Customer 78 "Charlotte" "Taylor" 19 "Samuel@hotmail.com" 8388.375 "High",
    Customer 79 "Sarah" "Wilson" 65 "Emily@gmail.com" 6037.5625 "Low",
    Customer 80 "Olivia" "Jones" 62 "John@hotmail.com" 8787.631 "Medium",
    Customer 81 "Isabella" "Jackson" 45 "Sarah@gmail.com" 1253.8618 "Medium",
    Customer 82 "Grace" "Jackson" 55 "Ava@hotmail.com" 2201.3718 "Low",
    Customer 83 "John" "Garcia" 52 "John@yahoo.com" 818.1381 "High",
    Customer 84 "James" "Davis" 52 "Samuel@hotmail.com" 8012.2783 "Medium",
    Customer 85 "David" "Williams" 67 "Alexander@example.com" 9429.432 "Low",
    Customer 86 "Sarah" "Anderson" 74 "David@yahoo.com" 2500.0078 "Low",
    Customer 87 "Samuel" "Taylor" 29 "Daniel@example.com" 760.37646 "High",
    Customer 88 "Willian" "Brown" 71 "Isabella@example.com" 4321.4927 "Low",
    Customer 89 "Alice" "Thompson" 77 "Sophia@example.com" 9091.631 "Low",
    Customer 90 "Bob" "Davis" 76 "John@yahoo.com" 9396.389 "High",
    Customer 91 "Willian" "Robinson" 71 "Charlotte@gmail.com" 4509.7827 "Medium",
    Customer 92 "Michael" "Davis" 58 "Michael@yahoo.com" 2395.2346 "High",
    Customer 93 "Alice" "Robinson" 24 "Henry@hotmail.com" 2274.0596 "High",
    Customer 94 "John" "Johnson" 31 "Ava@gmail.com" 2739.718 "Low",
    Customer 95 "Bob" "Martin" 40 "Henry@gmail.com" 8175.925 "High",
    Customer 96 "Charlotte" "Garcia" 67 "Henry@hotmail.com" 5461.2764 "Medium",
    Customer 97 "Sarah" "Smith" 55 "Henry@yahoo.com" 289.92474 "Medium",
    Customer 98 "Samuel" "White" 24 "Isabella@example.com" 3347.8184 "Low",
    Customer 99 "Henry" "Anderson" 57 "Grace@example.com" 9166.011 "Low",
    Customer 100 "James" "Taylor" 33 "Charlotte@yahoo.com" 2939.2595 "Low"
  ]

getCustomerAges :: [Customer] -> [Int]
getCustomerAges = map age

getCustomerBalances :: [Customer] -> [Float]
getCustomerBalances = map balance

getRiskNotes :: [Customer] -> [String]
getRiskNotes = map riskNote

displaySortedCustomersByBalance :: IO [Customer]
displaySortedCustomersByBalance = do
  let sortedCustomers = sortBy (\c1 c2 -> compare (balance c2) (balance c1)) customers
  return sortedCustomers

displaySortedCustomers :: IO ()
displaySortedCustomers = do
  let sortedCustomers = sortBy (\c1 c2 -> compare (customerId c1) (customerId c2)) customers
  putStrLn "Sorted Customers:"
  mapM_ print sortedCustomers

displayRiskManagement :: IO ()
displayRiskManagement = do
  putStrLn "Enter a balance threshold:"
  thresholdStr <- getLine
  let threshold = read thresholdStr :: Float
      filteredCustomers = filter (\c -> balance c < threshold && riskNote c == "High") customers
  putStrLn "Customers with Balance Below Threshold and High Risk Note:"
  mapM_ print filteredCustomers
