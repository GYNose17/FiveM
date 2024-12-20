dealershipConfig = {}

dealershipConfig.main = {
    dir = "http://104.234.65.51:/ultimate/carros/", -- Diretorio das imagens dos veiculos
    
    showVehicleOutStock = true, -- Mostrar na concessionaria veiculo sem estoque


    commandConce = 'conce',

    cooldownTestDriver = 120, -- TEMPO DO TEST DRIVER EM SEGUNDOS
    maxDistanceTestDriver = 1500.0, -- MAXIMO DE DISTANCIA QUE O JOGADOR PODE SE AFASTAR DA ZONA DO TEST-DRIVE

    sellVehicle = 99, -- PORCENTAGEM QUE VAI RECEBER DA CONCESSIONARIA APOS VENDER VEICULO
    maxCars = 5, -- Total de maximo de carros

    zoneVips = { -- DESCONTOS E MAXIMO DE CARROS NA GARAGEM
        { permission = "perm.vagas11", discount = 0, maxCars = 11 },
        { permission = "perm.vagas12", discount = 0, maxCars = 12 },
        { permission = "perm.vagas32", discount = 0, maxCars = 32 },
        { permission = "perm.vagas36", discount = 0, maxCars = 36 },
        
        { permission = "perm.vagastres", discount = 0, maxCars = 3 },
        { permission = "perm.inicial", discount = 5, maxCars = 5 },
        { permission = "perm.vipcopa", discount = 5, maxCars = 5 },
        
        { permission = "perm.bronze", discount = 5, maxCars = 5 },
        { permission = "perm.prata", discount = 7, maxCars = 7 },
        { permission = "perm.ouro", discount = 9, maxCars = 8 },
        { permission = "perm.platina", discount = 10, maxCars = 10 },
        { permission = "perm.diamante", discount = 13, maxCars = 15 },
        { permission = "perm.esmeralda", discount = 15, maxCars = 20 },
        { permission = "perm.safira", discount = 20, maxCars = 25 },
        { permission = "perm.rubi", discount = 20, maxCars = 25 },
        { permission = "perm.rubiplus", discount = 25, maxCars = 35 },
    }
}

dealershipConfig.locations = {
    {
        coords = vec3(-40.03,-1097.26,26.42),
        test_drive = vector4(-1973.56,2838.4,32.81,59.12),
    }
}