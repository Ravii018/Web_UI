import  json

def parameters():
    f = open('credentials.json')
    data = json.load(f)
    for i in data["Parameters_for_WebUI"]:
        #print(i)
        keys = list(i.keys())
        values = list(i.values())
        Lab_Name=values[0]
        URL=values[1]
        Lab_Username=values[2]
        Lab_Password=values[3]
        Paf_Username=values[4]
        Paf_Password=values[5]
    f.close()
    return Lab_Name,URL,Lab_Username,Lab_Password,Paf_Username,Paf_Password;
    
def chrome_type():
    f = open('credentials.json')
    data = json.load(f)
    #for i in data["Selection_of_chrome_type"]:
    p=data["Selection_of_chrome_type"]
    headless_chrome=p[0]["Headlesschrome"]
    f.close()
    return headless_chrome;
    
