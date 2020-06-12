test_that("Installs lightgbm", {
  platform <- Sys.info()["sysname"]
  if (!is_debian_based() || platform != "Linux") {
    install_lightgbm()
    data(agaricus.train, package = 'lightgbm')
    train <- agaricus.train
    dtrain <- lightgbm::lgb.Dataset(train$data, label=train$label)
    params <- list(objective = "regression", metric = "l2")
    model <- lightgbm::lgb.cv(
      params, dtrain, 10, nfold = 5, min_data = 1,
      learning_rate = 1, early_stopping_rounds = 10,
      verbose = -1
    )
    expect_equal(class(model), c("lgb.CVBooster", "R6"))
  } else {
    expect_equal(TRUE, TRUE)
  }

})
