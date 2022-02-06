require(rjson)
library(tidyr)
library(jsonlite)

result <- "BayviewAA.json"
json_data <- fromJSON(paste(readLines(result), collapse=""))

Rack = c()
Column = c()
Row = c()
Card_num = c()
Cage_ID = c()
Breeder = c()
Father = c()
Mother1 = c()
Mother2 = c()
Tag1 = c()
Tag2 = c()
Tag3 = c()
Tag4 = c()
Tag5 = c()
Note = c()
Lineage = c()

for(i in names(json_data)){
  for(j in names(json_data[[i]])){
    for(k in names(json_data[[i]][[j]])){
        ls = names(json_data[[i]][[j]][[k]])
        Rack = append(Rack,i)
        Row = append(Row,j)
        Column = append(Column,k)
        Card_num = append(Card_num,json_data[[i]][[j]][[k]][[ls[1]]])
        Cage_ID = append(Cage_ID,json_data[[i]][[j]][[k]][[ls[2]]])
        Breeder = append(Breeder,json_data[[i]][[j]][[k]][[ls[3]]])
        Lineage = append(Lineage, json_data[[i]][[j]][[k]][[ls[4]]])
        Father = append(Father, json_data[[i]][[j]][[k]][[ls[5]]])
        Mother1 = append(Mother1, json_data[[i]][[j]][[k]][[ls[6]]][[1]])
        Mother2 = append(Mother2, json_data[[i]][[j]][[k]][[ls[6]]][[2]])
        TagList = json_data[[i]][[j]][[k]][[ls[7]]]
        NumNA = rep(0, 5 - length(TagList))
        if(length(NumNA) == 5)
          TagList = NumNA
        else
          TagList = append(TagList, NumNA)
        
        Tag1 = append(Tag1, TagList[1])
        Tag2 = append(Tag2, TagList[2])
        Tag3 = append(Tag3, TagList[3])
        Tag4 = append(Tag4, TagList[4])
        Tag5 = append(Tag5, TagList[5])
 
        Note = append(Note, json_data[[i]][[j]][[k]][[ls[8]]])
     
    
    }
  }
}


Tag1 = as.numeric(Tag1)
Tag2 = as.numeric(Tag2) 
Tag3 = as.numeric(Tag3) 
Tag4 = as.numeric(Tag4)
Tag5 = as.numeric(Tag5)

df_tf = data.frame(Rack,Row, Column, Card_num, 
                   Cage_ID, Breeder, Lineage, Father, 
                   Mother1, Mother2, 
                   Tag1, Tag2, Tag3, Tag4, Tag5, 
                   Note)

write.csv(df_tf,"dt_tf.csv", row.names = FALSE)

