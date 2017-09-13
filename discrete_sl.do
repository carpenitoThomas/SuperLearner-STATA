/* 	This document is going to serve as the main file for the discrete superlearner algorithm in Stata.
	General plan for implementing discrete superlearner:
		1. User inputs: data, models (algorithms)
		2. Split the dataset into a specified number of folds (k?). Let's say 10 in this example.
			a. 9 of the folds will be required to train the data, the 10th will be the validation set.
			b. Each fold is responsible for being BOTH a training and validation set in each iteration.
		3. Fit each of the specified algorithms on each of the folds.
			a. If you have 10 folds and three algorithms, you will have thirty models fit.
		4. Predict whatever value is you're trying to predcit with the fitted models.
		5. Within each validation set, calculate the cross validated risk.
			a. Take the 
			a. Average the risk across all simulations for each validation.
		6. Discrete Super Learner will select the algorithm with the lowest cross validated risk.			

		For this project, we will start with just assuming a continuous outcome for the target parameter.
			- With that said, we will assume the L2 loss first.


SuperLearner <- function(Y, X, newX = NULL, family = gaussian(), SL.library,
                         method = 'method.NNLS', id = NULL, verbose = FALSE, control = list(),
                         cvControl = list(), obsWeights = NULL, env = parent.frame()) {			

CV.SuperLearner <- function(Y, X, V = NULL, family = gaussian(), SL.library, method = 'method.NNLS', id = NULL, verbose = FALSE, control = list(saveFitLibrary = FALSE), 
cvControl = list(), innerCvControl = list(), obsWeights = NULL, saveAll = TRUE, parallel = "seq", env = parent.frame()) {
  call <- match.call()
  N <- dim(X)[1L]                         	

*/
sysuse auto.dta

capture program drop discrete_sl
program define discrete_sl, rclass
	/* 	y = y values 
		x = x values 
		v = the number folds
		family = either gaussian or binomial
		library = various models for prediction
		discrete_sl mpg length,  v(10) family("gaussian") library("regress glm mixed")
	*/
	syntax varlist(min=2) , [if] [in] v(integer) family(string) library(string)
	
	*Step 1: Split dataset into specified number of folds
		* 1 less fold for validation, rest are training.
	
	* puts our library string in local macros `1', `2', `3', etc...
	tokenize `library'
	
	* loop thru the library and run models
	local i = 1
	
	while "‘‘i’’" != "" {
		``i'' `varlist'
		local ++i
	}	
	
end