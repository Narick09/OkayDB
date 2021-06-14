import psycopg2 as lib

def ReadStr():
	string = str(input())
	if string == "-" or string == "\n":
		return None
	else:
		return string

def ReadInt():
	intg = int(input())
	if intg == "-" or intg == "\n":
		return None
	#elif type(intg) == int or type(intg) == float:
	#	return int(intg)
	else:
		return intg

def CheckAllObjectsOf_Owners():
	print("Введите фамилию владельца")
	surname_ = ReadStr()
	print("Введите имя владельца")
	name_ = ReadStr()
	print("Введите отчество владельца")
	patronymic_ = ReadStr()
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from select_owners_objects(%(h1)s,%(h2)s,%(h3)s);'
	curs.execute(select_, {"h1": surname_, "h2": name_, "h3": patronymic_})
	for tmp in curs:
		print(tmp)
	#db_.commit()
	curs.close()
	db_.close()

def CheckAllObjectsOf_Agents():
	print("Введите фамилию сотрудника")
	surname_ = ReadStr()
	print("Введите имя сотрудника")
	name_ = ReadStr()
	print("Введите отчество сотрудника")
	patronymic_ = ReadStr()
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from select_agents_objects(%(h1)s,%(h2)s,%(h3)s);'
	curs.execute(select_, {"h1": surname_, "h2": name_, "h3": patronymic_})
	for tmp in curs:
		print(tmp)
	#db_.commit()
	curs.close()
	db_.close()

def CheckAllObjects():
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from Object where objectId not in (select Deal.objectId from Deal);'
	curs.execute(select_)
	for tmp in curs:
		print(tmp)
	#db_.commit()
	curs.close()
	db_.close()

def CheckObjects():
	ind = -1
	print("0 - вернуться в начало")
	print("1 - данные объектов по полному имени владельца")
	print("2 - данные объектов по полному имени агента")
	print("3 - данные обо всех объектах")
	while ind < 0:
		ind = ReadInt()
		if ind is None:
			return 0
		else:
			if ind == 1:
				CheckAllObjectsOf_Owners()
			elif ind == 2:
				CheckAllObjectsOf_Agents()
			elif ind == 0:
				return 0
			elif ind == 3:
				CheckAllObjects()
			else:
				print("Введите число либо 1 - ввод по полному имени, либо 2 - ввод по номеру телефона, либо 3 - просмотр всех клиентов")

def CheckAllClients():
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	curs.execute('select * from People where personId in (select buyerId from Buyers)')
	for tmp in curs:
		print(tmp)
	curs.close()
	db_.close()

def CheckClientBy_name():
	print("Введите фамилию\n")
	surname_ = ReadStr()
	print("Введите имя\n")
	name_ = ReadStr()
	print("Введите отчество\n")
	patronymic_ = ReadStr()
	print("Результат:")
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select Buyers.buyerId, tel.telephone_number, pas.pasport_number ' \
			  ' from Buyers, select_client_telephone(%(h1)s,%(h2)s,%(h3)s) as tel, ' \
			  'select_client_personal_data(%(h1)s,%(h2)s,%(h3)s) as pas ' \
			  'where Buyers.buyerId = tel.personId ' \
			  'and Buyers.buyerId=pas.personId'
	curs.execute(select_, {"h1": surname_, "h2": name_, "h3": patronymic_})
	for tmp in curs:
		print(tmp)
	curs.close()
	db_.close()
######################## change ########################
#def CheckClientBy_telephone():
#	print("Введите номер телефона с \"8\", без пробелов и других знаков")
#	tel_ = ReadStr()
#	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
#	curs = db_.cursor()
#	select_ = 'select Buyers.buyerId, cl.,  pas.pasport_number ' \
#			  ' from Buyers, ' \
#			  'select_client_name_by_telephone(%(h1)s) as cl, ' \
#			  'select_client_personal_data(%(h1)s,%(h2)s,%(h3)s) as pas ' \
#			  'where Buyers.buyerId = cl.personId ' \
#			  'and Buyers.buyerId=pas.personId'
#	curs.execute(select_, {"h1": surname_, "h2": name_, "h3": patronymic_})
#	for tmp in curs:
#		print(tmp)
#	curs.close()
#	db_.close()
########################################################################

def CheckClient():
	ind = -1
	print("0 - вернуться в начало")
	print("1 - данные клиента по полному имени")
	print("2 - данные обо всех клиентах")
	while ind < 0:
		ind = ReadInt()
		if ind is None:
			return 0
		else:
			if ind == 1:
				CheckClientBy_name()
			elif ind == 2:
				CheckAllClients()
			elif ind == 0:
				return 0
			else:
				print("Введите число либо 1 - ввод по полному имени, либо 2 - просмотр всех клиентов")

#changing tables
def ChangeBD():
	print("Что вы хотите изменить?")
	print("0 - Вернуться в начало")
	print("1 - Добавить/изменить данные о человеке в БД")
	print("2 - Удалить человека из БД")
	print("3 - Добавить объект в БД")
	print("4 - Добавить сделку")
	print("5 - Удалить сделку")
	print("6 - Удалить объект")
	ind = -1
	while ind < 0:
		ind = ReadInt()
		if ind is None:
			return 0
		else:
			if ind == 1:
				AddPersonToDB()
			elif ind == 2:
				DeletePersonFromDB()
			elif ind == 0:
				return 0
			elif ind == 3:
				AddObject()
			elif ind == 4:
				AddToDeal()
			elif ind == 5:
				RemoveDeal()
			elif ind == 6:
				RemoveObj()
			else:
				print("Введите корректное число!")

def AddPersonToDB():
	print("Введите фамилию\n")
	surname_ = ReadStr()
	print("Введите имя\n")
	name_ = ReadStr()
	print("Введите отчество\n")
	patronymic_ = ReadStr()
	print("Введите паспортные данные\n")
	pass_data_ = ReadStr()
	print("Введите номер телефона\n")
	tel_num_ = ReadStr()

	print("Введите статус: агент/продавец/покупатель")
	status_ = ReadStr()
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	if status_ == "агент":
		print("Введите стаж работы:")
		tmpVal = ReadInt()
		select_ = 'select * from add_agent(%(h1)s, %(h2)s, %(h3)s, %(h4)s, %(h5)s, %(h6)s);'
		curs.execute(select_,
					 {"h1": surname_, "h2": name_, "h3": patronymic_, "h4": tel_num_, "h5": pass_data_, "h6": tmpVal})
	elif status_ == "покупатель":
		print("Введите индекс надежности(от 0 до 100):")
		tmpVal = ReadInt()
		select_ = 'select * from add_buyer(%(h1)s,%(h2)s,%(h3)s, %(h4)s, %(h5)s, %(h6)s);'
		curs.execute(select_,
					 {"h1": surname_, "h2": name_, "h3": patronymic_, "h4": tel_num_, "h5": pass_data_, "h6": tmpVal})
	elif status_ == "продавец":
		select_ = 'select * from add_owner(%(h1)s,%(h2)s,%(h3)s, %(h4)s, %(h5)s);'
		curs.execute(select_,
					 {"h1": surname_, "h2": name_, "h3": patronymic_, "h4": tel_num_, "h5": pass_data_})
	else:
		print("Ошибка: некорректный статус человека")
		curs.close()
		db_.close()
		return -1
	for row in curs:
		print(row[0])
	db_.commit()
	curs.close()
	db_.close()

def DeleteAgent(surname_, name_, patronymic_):
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from delete_agent(%(h1)s,%(h2)s,%(h3)s);'
	curs.execute(select_, {"h1": surname_, "h2": name_, "h3": patronymic_})
	for tmp in curs:
		print(tmp)
	db_.commit()
	curs.close()
	db_.close()

def DeleteClient(surname_, name_, patronymic_):
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from delete_client(%(h1)s,%(h2)s,%(h3)s);'
	curs.execute(select_, {"h1": surname_, "h2": name_, "h3": patronymic_})
	for tmp in curs:
		print(tmp)
	db_.commit()
	curs.close()
	db_.close()

def DeleteOwner(surname_, name_, patronymic_):
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from delete_owner(%(h1)s,%(h2)s,%(h3)s);'
	curs.execute(select_, {"h1": surname_, "h2": name_, "h3": patronymic_})
	for tmp in curs:
		print(tmp)
	db_.commit()
	curs.close()
	db_.close()

def DeletePerson(surname_, name_, patronymic_):
	DeleteAgent(surname_, name_, patronymic_)
	DeleteOwner(surname_, name_, patronymic_)
	DeleteClient(surname_, name_, patronymic_)
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from delete_person(%(h1)s,%(h2)s,%(h3)s);'
	curs.execute(select_, {"h1": surname_, "h2": name_, "h3": patronymic_})
	for tmp in curs:
		print(tmp)
	db_.commit()
	curs.close()
	db_.close()

def DeletePersonFromDB():
	print("0 - Вернуться в начало")
	print("1 - Удалить человека из списка сотрудников")
	print("2 - Удалить человека из списка владельцев")
	print("3 - Удалить человека из списка клиентов")
	print("4 - Удалить человека из базы данных")
	ind = -1
	while ind < 0:
		ind = ReadInt()
		if ind is None or ind < 0 or ind > 4:
			print("Введите корректное число!")
		else:
			print("Введите фамилию\n")
			surname_ = ReadStr()
			print("Введите имя\n")
			name_ = ReadStr()
			print("Введите отчество\n")
			patronymic_ = ReadStr()
			if ind == 1:
				DeleteAgent(surname_, name_, patronymic_)
			elif ind == 2:
				DeleteOwner(surname_, name_, patronymic_)
			elif ind == 3:
				DeleteClient(surname_, name_, patronymic_)
			elif ind == 4:
				DeletePerson(surname_, name_, patronymic_)
			elif ind == 0:
				return 0

def AddObject():
	print("Введите район")
	district_ = ReadStr()
	print("Введите улицу")
	street_ = ReadStr()
	print("Введите номер дома")
	build_num_ = ReadInt()
	print("Введите число этажей")
	floors_amount_ = ReadInt()
	print("Введите идентификатор владельца")
	id_o = ReadInt()
	print("Введите идентификатор сотрудника")
	id_a = ReadInt()

	print("Введите тип объекта(Комната или Квартира)")
	obj_type_ = ReadStr()
	print("Введите цену")
	price_ = ReadInt()
	print("Введите площадь")
	area_ = ReadInt()
	print("Введите этаж")
	floor_ = ReadInt()
	print("Введите число комнат")
	amonut_of_rooms_ = ReadInt()
	print("Введите номер квартиры/комнаты")
	object_num_ = ReadInt()
	print("Дополнительное описание?")
	additional_description_ = ReadStr()

	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from add_object(%(h1)s,%(h2)s,%(h3)s, %(h4)s,%(h5)s,%(h6)s, %(h7)s,%(h8)s,%(h9)s, %(h10)s,%(h11)s,%(h12)s,' \
			  '%(h13)s);'
	curs.execute(select_, {"h1": district_,"h2": street_,"h3":build_num_, "h4":floors_amount_,"h5": id_o,
				 "h6": id_a, "h7": obj_type_,"h8": price_,"h9": area_, "h10": floor_,"h11": amonut_of_rooms_,
						   "h12": object_num_, "h13": additional_description_})
	for tmp in curs:
		print(tmp)
	db_.commit()
	curs.close()
	db_.close()

def AddToDeal():
	print("Object id:")
	obj_id_ = ReadInt()
	print("Client id:")
	cl_id_ = ReadInt()
	print("Deal type(Обычная, Альтернативная)")
	dt = ReadStr()
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'select * from add_deal(%(h1)s, %(h2)s, %(h3)s);'
	curs.execute(select_, {"h1": obj_id_, "h2": cl_id_, "h3": dt})
	for tmp in curs:
		print(tmp[0])
	db_.commit()
	curs.close()
	db_.close()

def RemoveDeal():
	print("Deal id:")
	d_id_ = ReadInt()
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'delete from Deal where dealId = %(h1)s'
	curs.execute(select_, {"h1": d_id_})
	print("deleted")
	db_.commit()
	curs.close()
	db_.close()

def RemoveObj():
	print("Object id:")
	o_id_ = ReadInt()
	db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
	curs = db_.cursor()
	select_ = 'delete from object where objectId = %(h1)s'
	curs.execute(select_, {"h1": o_id_})
	print("deleted")
	db_.commit()
	curs.close()
	db_.close()

actions = [CheckClient, CheckObjects, ChangeBD]
actionsNumber = len(actions)
