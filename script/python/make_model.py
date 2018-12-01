import fastText as ft
import sys

def main(argv):
    input_file = argv[0]
    output_file = argv[1]
    model = ft.train_supervised(input=input_file, 
      dim=200,
      epoch=30,
      lr=0.1,
      label='__label__', 
      thread=8)
    model.save_model(output_file)
if __name__ == '__main__':
    main(sys.argv[1:])
