def class_satisfação(nota):
    if nota > 90:
        return "Atendimento de Qualidade!"
    elif 70 <= nota <= 89:
        return "Atendimento Razoável!"
    else:
        return "Atendimento Insatisfatório!"
nota_satisfação = float(input("Digite a nota de satisfação (0 a 100): "))    
resultado= class_satisfação(nota_satisfação)
print(resultado)