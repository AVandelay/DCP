<details>
<summary>
<b>Decision Trees</b>
<br>
</summary>

## What are Decision Trees?
Decision trees are a popular and easy-to-understand machine learning algorithm used for both classification and regression tasks. They work by recursively splitting the input data into subsets based on the values of the input features, and then making a decision based on the majority class or average value in each subset.

### Advantages of Decision Trees
    a. Interpretability: Decision trees are simple to understand and interpret, making them ideal for situations where transparency and explainability are important.

    b. Handling of both numerical and categorical data: Decision trees can handle both continuous and discrete input features, simplifying the preprocessing steps.

    c. Non-parametric: Decision trees are non-parametric, meaning they make no assumptions about the underlying distribution of the data, which can be advantageous when dealing with non-linear relationships.

    d. Handling missing values: Decision trees can handle missing data gracefully by using surrogate splits, which enable them to continue building the tree even when data is incomplete.

### Disadvantages of Decision Trees
    a. Overfitting: Decision trees are prone to overfitting, especially when the tree is deep. This can be mitigated by pruning techniques or setting a maximum depth.

    b. Sensitivity to small changes in data: Decision trees can be sensitive to small changes in the training data, which may result in entirely different trees being built.

    c. Greedy algorithm: The splitting criteria used in decision trees are based on a greedy algorithm, meaning they optimize for the best split at each step, which may not lead to the globally optimal tree.

## Limitations of Related Algorithms
    a. Random Forests: A popular ensemble method that builds multiple decision trees and combines their predictions. While it reduces overfitting and increases accuracy, it sacrifices interpretability, as the ensemble model becomes harder to interpret than a single decision tree.

    b. Gradient Boosted Machines (GBMs): Another ensemble method that builds decision trees sequentially, where each tree tries to correct the errors made by the previous one. GBMs can achieve high accuracy but can be more prone to overfitting, and they require careful tuning of hyperparameters. Additionally, they also sacrifice interpretability.

Decision trees are a versatile and interpretable machine learning algorithm, suitable for a variety of tasks. However, they can suffer from overfitting and sensitivity to small changes in data. Ensemble methods like Random Forests and GBMs help mitigate some of these issues but come with their own limitations, such as reduced interpretability and increased complexity.
</details>