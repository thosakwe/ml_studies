import numpy as np
import tensorflow as tf
from keras import optimizers
from keras.layers import Dense
from keras.models import Sequential
tf.logging.set_verbosity(tf.logging.ERROR)

model = Sequential()
model.add(Dense(1, activation='linear', input_dim=1))
model.compile(loss='mean_squared_error',
              optimizer=optimizers.RMSprop(lr=0.1),
              metrics=['mean_squared_error'])

# The function is y = 3x - 2
# Create 100 training values
x_train = np.arange(0, 100)
y_train = (x_train * 3) - 2

model.fit(x_train, y_train, epochs=100, verbose=0)

print("Actual equation: y = 3x - 2")

while True:
    x = float(input("Enter an x value: "))
    arr = np.array([x])
    out = model.predict(arr)[0][0]
    out = round(out)
    print("Computed (rounded): " + str(out))
    print("Actual: " + str(3 * x - 2))