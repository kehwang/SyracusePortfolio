# Movie Review Text and Sentiment Classification

The movie review dataset was produced for a Kaggle competition, taken from the original Pang and Lee movie review corpus based on reviews from the Rotten Tomatoes website. Using sentiment data by Socher et al, Socher's group used crowd-sourcing to manually annotate all the subphrases of sentences with a sentiment label ranging from negative, somewhat negative, neutral, somewhat positive, to positive.

This is a text classification demonstration using NLTK.

### Techniques Utilized

Programming Language: Python<br>
Natural Language Processing<br>
- Tokenization
- Bag of Words
- Text Processing: removing stopwords, non alphanumeric characters, lexicon use
- Frequency Analysis
- Feature Building<br>

Classification using:
- Naive Bayes (NLTK)
- Multinomial Naive Bayes (SKLearn)
- Logistic Regression (SKLearn)
- Random Forest (SKLearn)

### Data Sources
https://www.kaggle.com/c/sentiment-analysis-on-movie-reviews
http://nlp.stanford.edu/sentiment/

### Contents
- train.tsv - Training data with over 156,060 phrases
- test.tsv - Testing data for validation
- review_classification.ipynb - Annotated jupyter notebook
