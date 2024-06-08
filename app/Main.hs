{-# LANGUAGE BlockArguments #-}

module Main (main) where

import DataAnalysis (calculateAverageAge, calculateAverageBalance, calculateAverageRisk, calculateRiskString, showTopBalanceUserSelected)
import System.IO (hFlush, stdout)
import UserManagement
  ( customers,
    displayRiskManagement,
    displaySortedCustomers,
  )

printMainMenu :: IO ()
printMainMenu = do
  putStrLn "Choose an option: "
  putStrLn "1. List All Customers"
  putStrLn ">>>>>>>>>>> Customer Data Analysis"
  putStrLn "2.1 Customer Average Age"
  putStrLn "2.2 Customer Average Balance"
  putStrLn "2.3 Customer Average Risk (Float)"
  putStrLn "2.4 Customer Average Risk (Enum)"
  putStrLn "2.5 List Top N Customer Balances"
  putStrLn ">>>>>>>>>>> Risk Analysis"
  putStrLn "3. List High Risk Customers"
  putStrLn "4. Exit"
  putStrLn "Please enter your choice(1-4 and subtitles of 2s) : "
  hFlush stdout

-- case yapısı kurdum
handleUserChoice :: String -> IO ()
handleUserChoice "1" = displaySortedCustomers
handleUserChoice "2.1" = do
  let averageAge = calculateAverageAge customers
  putStrLn $ "Average age of customers: " ++ show averageAge
handleUserChoice "2.2" = do
  let averageBalance = calculateAverageBalance customers
  putStrLn $ "Average balance of customers: " ++ show averageBalance
handleUserChoice "2.3" = do
  let averageRisk = calculateAverageRisk customers
  putStrLn $ "Average risk of customers: " ++ show averageRisk
handleUserChoice "2.4" = do
  let averageRisk = calculateAverageRisk customers
      riskString = calculateRiskString averageRisk
  putStrLn $ "Average risk enum : " ++ riskString
handleUserChoice "2.5" = showTopBalanceUserSelected
handleUserChoice "3" = do
  putStrLn "Listing high risk customers..."
  displayRiskManagement
handleUserChoice "4" = putStrLn "Exiting. See you again"
handleUserChoice _ = putStrLn "Invalid option. Please try again."

-- menüyü gösteriyorum assign işlemleri yaptım
main :: IO ()
main = do
  printMainMenu
  choice <- getLine
  handleUserChoice choice
  if choice /= "4"
    then main
    else putStrLn "Thanks for using our Fintech Project"
