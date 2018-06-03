
from django.db.models import Q


def get_query(char_list):
    q_objects = Q()

    q_objects.add(Q(hypoallergenic=char_list[0]), Q.AND)
    q_objects.add(Q(active=char_list[1]), Q.AND)
    q_objects.add(Q(trained=char_list[2]), Q.AND)

    size_query = Q()

    for i in range(3, 6):
        if char_list[i] is True:
            if i == 3:
                size_query.add(Q(size=0), Q.OR)
            elif i == 4:
                size_query.add(Q(size=1), Q.OR)
            elif i == 5:
                size_query.add(Q(size=2), Q.OR)

    q_objects.add(size_query, Q.AND)

    age_query = Q()

    for i in range(6, 9):
        if char_list[i] is True:
            if i == 6:
                age_query.add(Q(age_range=0), Q.OR)
            if i == 7:
                age_query.add(Q(age_range=1), Q.OR)
            if i == 8:
                age_query.add(Q(age_range=2), Q.OR)

    q_objects.add(age_query, Q.AND)

    return q_objects







