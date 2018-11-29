import sys
import fastText as ft

class predict:

    def __init__(self):
        # モデル読み込み
        input_file = sys.argv[1:][0]
        self.classifier = ft.load_model(input_file)

    def tweet_class(self, content):
        words = " ".join(content)
        estimate = self.classifier.predict(text=[words], k=7)
       
        for i in range(0, len(estimate[0][0])):       
            print(estimate[0][0][i])
            print(estimate[1][0][i])

if __name__ == '__main__':
    pre = predict()
    pre.tweet_class("".join(sys.argv[2:]))
