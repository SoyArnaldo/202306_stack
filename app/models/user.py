"""User models."""

# Config
from app.config.mysql_connection import connect_to_mysql
from flask import flash
from app.utils.regex import EMAIL_REGEX


class User:
    """Modelo de la clase `User`."""

    def __init__(self, data: dict) -> None:
        """Constructor de la clase `User`."""
        
        self.id = data["id"]
        self.first_name = data["first_name"]
        self.last_name = data["last_name"]
        self.email = data["email"]
        self.password = data["password"]
        self.created_at = data["created_at"]
        self.updated_at = data["updated_at"]
    
    @classmethod
    def create(cls, data: dict):
        query = """
        INSERT INTO users (first_name, last_name, email, password) 
        VALUES (%(first_name)s, %(last_name)s, %(email)s, %(password)s);
        """
        return connect_to_mysql().query_db(query, data)
    
    @classmethod
    def get_by_id(cls, data: dict):
        query = """SELECT * FROM users WHERE id = %(id)s;"""
        results = connect_to_mysql().query_db(query,data)
        return cls(results[0])
    
    @classmethod
    def get_by_email(cls, data: dict):

        query = """SELECT * FROM users WHERE email = %(email)s;"""
        result = connect_to_mysql().query_db(query, data)
        print("=======> CORREO REGISTRADO",result)
        if result:
            return cls(result[0])
        return None

    @classmethod
    def validate(cls, data):
        is_valid = True
        if not EMAIL_REGEX.match((data["email"])):
            flash("Ingresa un correo válido", "info")
            is_valid = False
        if len(data["first_name"]) < 2:
            flash("First name min 2 characters ", "info")
            is_valid = False
        if len(data["last_name"]) < 2:
            flash("Last name min 2 characters ", "info")
            is_valid = False
        if len(data["password"]) < 8:
            is_valid = False
            flash("Password min 8 characters ", "info")
        return is_valid
