# vignette-XGBoost

Vignette on implementing XGBoost using credit card fraud data; created as a class project for PSTAT197A in Fall 2023.

Contributors: Mu Niu, Qifei Cui, Yixin Xue, Amber Wang, David Lin

Vignette abstract: Our vignette presents a comprehensive exploration of XGBoost, including its mathematical principles, programming language support, and practical application in classification problems. Our vignette is conducted on a simulated “Credit Card Fraud” dataset obtained on Kaggle (https://www.kaggle.com/datasets/dhanushnarayananr/credit-card-fraud/data). This dataset presents a binary classification problem, classifying transactions as either fraudulent or legitimate. With 8 variables and a total of 1,000,000 observations. Our model has an AUC score of 0.99988, indicating that the model is almost a perfect classifier. Such an unusual result is probably because the simulated dataset is designed for practice purposes.

Repository contents: 
```
root directory
├── data
   ├── raw
   ├── processed
├── scripts
   ├── drafts
   ├── vignette-script.R
├── img
├── vignette.qmd
├── vignette.html
├── README.md 
├── vignette-xgboost.Rproj
```

Reference list: 

- Chen, Tianqi, and Carlos Guestrin. "Xgboost: A scalable tree boosting system." Proceedings of the 22nd acm sigkdd international conference on knowledge discovery and data mining. 2016.

- He, Shen, et al. “An Effective Cost-Sensitive XGBoost Method for Malicious Urls Detection in Imbalanced Dataset.” IEEE Access, vol. 9, 2021, pp. 93089–93096, doi:10.1109/access.2021.3093094. 

- Narayanan R, Dhanush. “Credit Card Fraud”, https://www.kaggle.com/datasets/dhanushnarayananr/credit-card-fraud/data. Accessed 06 Dec. 2023. 

- “XGBoost Documentation.” XGBoost Documentation - Xgboost 2.0.2 Documentation, xgboost.readthedocs.io/. 

