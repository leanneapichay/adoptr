
from django.db.models import Q


def get_query(char_list):
    q_objects = Q()

    q_objects.add(Q(hypoallergenic=char_list[0]), Q.AND)
    q_objects.add(Q(active=char_list[1]), Q.AND)
    q_objects.add(Q(trained=char_list[2]), Q.AND)

    num = 0

    for i in range(3, 6):
        if char_list[i] is True:
            num += 1

    if num != 0:
        for i in range(3, 6):
            if char_list[i] is True and num > 1:
                if i == 3:
                    q_objects.add(Q(size=0), Q.OR)
                elif i == 4:
                    q_objects.add(Q(size=1), Q.OR)
                elif i == 5:
                    q_objects.add(Q(size=2), Q.OR)

                num -= 1

            elif char_list[i] is True and num == 1:
                if i == 3:
                    q_objects.add(Q(size=0), Q.AND)
                elif i == 4:
                    q_objects.add(Q(size=1), Q.AND)
                elif i == 5:
                    q_objects.add(Q(size=2), Q.AND)

    num = 0

    for i in range(6, 9):
        if char_list[i] is True:
            num += 1

    if num != 0:
        for i in range(6, 9):
            if char_list[i] is True and num > 1:
                if i == 6:
                    q_objects.add(Q(age=0), Q.OR)
                if i == 7:
                    q_objects.add(Q(age=1), Q.OR)
                if i == 8:
                    q_objects.add(Q(age=2), Q.OR)
            elif char_list[i] is True and num == 1:
                if i == 6:
                    q_objects.add(Q(age=0), Q.AND)
                if i == 7:
                    q_objects.add(Q(age=1), Q.AND)
                if i == 8:
                    q_objects.add(Q(age=2), Q.AND)

    return q_objects








