import random
import pandas as pd
n = 60

X1_values = []
X2_values = []
y_values = []
y_noisy_values = []

for _ in range(n):
    X1 = random.randint(1, 100)
    X2 = random.randint(1, 100)
    y = 3 - 4 * X1 + 5 * X2
    y_noisy = y + random.randint(-3, 3)

    X1_values.append(X1)
    X2_values.append(X2)
    y_values.append(y)
    y_noisy_values.append(y_noisy)

df = pd.DataFrame({
    "X1": X1_values,
    "X2": X2_values,
    "y": y_values,
    "y_noisy": y_noisy_values
})

excel_file = "generated_data_with_noise.xlsx"
df.to_excel(excel_file, index=False)

print(f"Дані збережено у файл {excel_file}")
