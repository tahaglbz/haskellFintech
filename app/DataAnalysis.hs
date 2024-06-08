{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module DataAnalysis
  ( calculateAverageAge,
    calculateAverageBalance,
    calculateAverageRisk,
    calculateRiskString,
    showTopBalanceUserSelected,
  )
where

import UserManagement (Customer, displaySortedCustomersByBalance, getCustomerAges, getCustomerBalances, getRiskNotes)

calculateAverageAge :: [Customer] -> Float
calculateAverageAge [] = 0
calculateAverageAge customers = fromIntegral (sum ages) / fromIntegral (length ages)
  where
    ages = getCustomerAges customers

calculateAverageBalance :: [Customer] -> Float
calculateAverageBalance [] = 0
calculateAverageBalance customers = sum balances / fromIntegral (length balances)
  where
    balances = getCustomerBalances customers

riskConvertFl :: String -> Float
riskConvertFl "High" = 3.0
riskConvertFl "Medium" = 2.0
riskConvertFl "Low" = 1.0

calculateAverageRisk :: [Customer] -> Float
calculateAverageRisk [] = 0.0
calculateAverageRisk customers = totalRisk / fromIntegral (length customers)
  where
    riskNotes = getRiskNotes customers
    riskValues = map riskConvertFl riskNotes
    totalRisk = sum riskValues

calculateRiskString :: Float -> String
calculateRiskString risk
  | risk > 2.5 = "High"
  | risk > 1.5 = "Medium"
  | otherwise = "Low"

showTopBalanceUserSelected :: IO ()
showTopBalanceUserSelected = do
  putStrLn "How many people do you want to see with the highest balance value"
  n <- getLine
  let nCustomers = read n :: Int
  sortedCustomers <- displaySortedCustomersByBalance
  let topNCustomers = take nCustomers sortedCustomers
  putStrLn $ "Top " ++ show nCustomers ++ " customer balances:"
  mapM_ print topNCustomers