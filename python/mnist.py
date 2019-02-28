#!/usr/bin/env python
from __future__ import print_function
from keras.datasets import mnist
from keras.layers import Conv2D, Dense, Dropout, Flatten, MaxPooling2D
from keras.models import Sequential

# Load the mnist data.
(x_train, y_train), (x_test, y_test) = mnist.load_data()

# x_train = (60k, 28, 28)
# y_train = (60k, 1)

model = Sequential()

# Use a convolutional layer (2D because our images are 2D).
# The input shape corresponds with the dimensions of the images.
#
# The window size is 3x3. Windows are explained here:
# https://medium.com/machine-learning-world/convolutional-neural-networks-for-all-part-ii-b4cb41d424fd
#
# Activation is RelU. f(x) = max(x, 0)
# https://github.com/Kulbear/deep-learning-nano-foundation/wiki/ReLU-and-Softmax-Activation-Functions
#
# "The more filters you apply, the more details the CNN is capable to recognize."
# Also from:
# https://medium.com/machine-learning-world/convolutional-neural-networks-for-all-part-ii-b4cb41d424fd
(_, x_dim, y_dim) = x_train.shape
model.add(Conv2D(32,
                 activation='relu',
                 input_shape=(x_dim, y_dim),
                 kernel_size=(3, 3)))

# Stack another conv2d on, with double the number of filters.
# It's (kind of) explained why here:
# https://datascience.stackexchange.com/questions/9175/how-do-subsequent-convolution-layers-work
model.add(Conv2D(64, (3, 3), activation='relu'))

# "Max pooling selects the maximum value of all selected squares to make feature detection more robust."
#
# In this case, we pick from 2x2 units (4 pixel squares)
#
# ALSO from here:
# https://medium.com/machine-learning-world/convolutional-neural-networks-for-all-part-ii-b4cb41d424fd
model.add(MaxPooling2D(pool_size=(2, 2)))

# Dropout prevents overfitting by randomly ignoring some data.
model.add(Dropout(0.5))

# A Flatten layer reshapes data into one-dimensional arrays.
#
# For example, if we had the shape (None, 45, 3),
# it would produce (None, 135).
model.add(Flatten())

# TODO: Why are producing 128 units, exactly?
model.add(Dense(128, activation='relu'))

# TODO: Why another drop out?
model.add(Dropout(0.5))

# TODO: Why exactly 10 classes?
# TODO: Why softmax?
model.add(Dense(10, activation='softmax'))

# TODO: Why crossentropy?
# TODO: Why Adadelta?
# TODO: Why accuracy?
model.compile(loss='categorical_crossentropy',
              optimizer='adadelta',
              metrics=['accuracy'])

# TODO: Explain this?
model.fit(x_train, y_train,
          batch_size=128,
          epochs=12,
          validation_data=(x_test, y_test))

score = model.evaluate(x_test, y_test, verbose=0)
print('Test loss:', score[0])
print('Test accuracy:', score[1])