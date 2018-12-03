import sys
import json
import fastText as ft

class predict:

    def __init__(self):
        # モデル読み込み
        input_file = sys.argv[1:][0]
        self.classifier = ft.load_model(input_file)

    def tweet_class(self, content):
        words = " ".join(content)
        estimate = self.classifier.predict(text=[words], k=7)
        dict = {}
        for i in range(0, len(estimate[0][0])):
            dict[estimate[0][0][i]] = estimate[1][0][i]
        return json.dumps(dict)
if __name__ == '__main__':
    pre = predict()
    sys.stdout.write(pre.tweet_class("".join(sys.argv[2:])))
