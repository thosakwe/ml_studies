import numpy as np
from keras.models import Sequential
from keras.layers import Dense

model = Sequential()
model.add(Dense(units=1, activation='relu', input_dim=1))
model.compile(loss='mean_squared_error',
              optimizer='sgd'
              metrics=['accuracy'])

# The function is y = 3x - 2
# Create 100 training values
x_train = np.arange(0, 100)
y_train = (x_train * 3) - 2

model.fit(x_train, y_train, epochs=10, batch_size=10)
ys = model.predict(x_train)
print(ys)
