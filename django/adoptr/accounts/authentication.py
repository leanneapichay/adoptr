from .models import User


class AuthBackend:

    @staticmethod
    def authenticate(email, password):
        try:
            user = User.objects.get(email=email)
            if user.check_password(raw_password=password):  # not passing this section
                return user
            else:
                return None
        except User.DoesNotExist:
            return None
