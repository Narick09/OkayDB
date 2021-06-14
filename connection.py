import psycopg2 as lib

def connection():
	try:
		print('Start connection to database')
		db_ = lib.connect(dbname="postgres", user="postgres", password="1", host="127.0.0.1", port="5432")
		curs = db_.cursor()
		print("Some information:", db_.get_dsn_parameters(),"\n")
		curs.execute("SELECT version();")
		print("Connected to ", curs.fetchone(), "\n")
	except (Exception, lib.Error) as error:
		print("Error while working with PostgreSQL", error)
	finally:
		if db_:
			curs.close()
			db_.close()
			print("Connection with PostgreSQL closed")
