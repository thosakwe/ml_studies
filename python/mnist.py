from keras.datasets import mnist
from keras.layers import Dense
from keras.models import Sequential

# Load the mnist data.
(x_train, y_train), (x_test, y_test) = mnist.load_data()

model = Sequential()
model.add(Dense(1))
model.compile(loss='mse',
              optimizer='rmsprop',
              metrics=['mse'])
model.fit(x_train, y_train, epochs=10)
