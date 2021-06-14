import connection as con
import actions as ac

def Greeting():
	print("\n\n\n")
	print("Estate agency Income")
	print("--------------------")

def ClosingProgram():
	print("Закрытие")
	#some closing actions mb
	print("Программа закрыта")

def ChooseAction():
	print("\tДействия:")
	print("0 - Выход из программы\n"
		"1 - мониторинг клиентов\n"
		  "2 - мониторинг объектов\n"
		  "3 - изменение базы данных\n")
	print('Choose action:\n')
	num = ac.ReadInt()
	if num is None:
		return -1
	if num < 0 or num > ac.actionsNumber:
		print("!!!!!!!!!!!!!!!!!!")
		print('Пожалуйста, выберете число от 0 до ', ac.actionsNumber)
		print("!!!!!!!!!!!!!!!!!!")
		return -1
	return num

if __name__ == "__main__":
	con.connection()
	Greeting()
	choosenAction = 1
	while (choosenAction):
		choosenAction = ChooseAction()
		if choosenAction >= 1:
			ac.actions[choosenAction - 1]()
	ClosingProgram()
