from enum import unique
import pyodbc 
import pandas as pd
import streamlit as st

conn = pyodbc.connect('Driver={SQL Server Native Client 11.0};'
                      'Server=localhost;'
                      'Database=Class_MetaData;'
                      'Trusted_Connection=yes;')


query1 = '''select * from [Database]'''

query2 = '''select EntitiyName, EntitiyCreationDate, EntitiyDescription, EntitiyCreatedBy, DatabaseName from Entitiy;'''

query3 = '''select a.AttributeName, adt.AttributeDataTypeId, adt.AttributeDataTypeRange, adt.AttributeDataTypeValue 
            from attribute a 
            join AttributeDataType adt
				on a.AttributeDataType_AttributeDataTypeId = adt.AttributeDataTypeId'''

query4 = '''select bt.BusinessID, bt.BusinessTerms, bt.BusinessTermsDescription, bt.DataType, a.DatabaseName
            from attribute a
            join BusinessTerm_has_Attribute bta
                on a.AttributeId = bta.Attribute_AttributeId
            join BusinessTerm bt
                on bt.BusinessID = bta.BusinessTerm_BusinessID'''

query5 = '''select a.EntityName, a.AttributeName, bt.BusinessTermsDescription, a.AttributeType 
            from Attribute a
            join BusinessTerm_has_Attribute bha
                on a.AttributeId = bha.Attribute_AttributeId
            join BusinessTerm bt
	            on bt.BusinessID = bha.BusinessTerm_BusinessID;'''

query6 = '''select r.RelationID, r.EntityName1, r.Relation, r.EntityName2, e.DatabaseName 
            from Entitiy e
            join Entitiy_has_Relations ehr 
                on e.EntitiyId = ehr.Entitiy_EntitiyId
            join Relations r
                on ehr.Relations_RelationID = r.RelationID;'''

df1 = pd.read_sql(query1 , conn)
df2 = pd.read_sql(query2 , conn)
df3 = pd.read_sql(query3 , conn)
df4 = pd.read_sql(query4 , conn)
df5 = pd.read_sql(query5 , conn)
df6 = pd.read_sql(query6 , conn)

st.title("Business and Technical Metadata")
st.header("What is Metadata?")
st.markdown("Metadata is data that describes and gives information about other data. It helps to organize, find and understand data. It refers to information of schema and all the other information regarding access, storage, built-in programs, or any other information about database elements or usage.")
st.header("What is Technical Metadata?")
st.markdown("Technical metadata represents the technical aspects of data, which includes database system names, table and column names and sizes, data types, lengths, and allowed values. This is essential for data presentation, manipulation, and analysis. ")
st.header("What is Business Metadata")
st.markdown("Business metadata is concerned with giving data meaning in the context of the organization. The business interpretation of data elements in the database is based on the actual table and column names in the database. Business metadata gathers this mapping information, business definitions, and rules information.")

st.header("Check the box below to view the deatils")

Menu_Items = list(df1['DatabaseName'].unique())
Menu_Choices = st.sidebar.selectbox('Select a Database', Menu_Items)

bus2 = st.checkbox('View Entity')
bus6 = st.checkbox('View Relations')

if bus2:
    filtered_df2 = df2[df2['DatabaseName'] == Menu_Choices]
    st.write('Entity: ')
    st.table(filtered_df2)
    Entity_Items = list(filtered_df2['EntitiyName'].unique())
    Entity_Choices  = st.sidebar.selectbox('Select Entity to see attributes', Entity_Items)
    filtered_df5 = df5[df5['EntityName'] == Entity_Choices]
    st.write('Attributes')
    st.table(filtered_df5)
    Attribute_Items = list(filtered_df5['AttributeName'].unique())
    Attribute_Choices = st.sidebar.selectbox('Select Attribute to see its details', Attribute_Items)
    filtered_df3 = df3[df3['AttributeName'] == Attribute_Choices]
    st.write('Attribute Type')
    st.table(filtered_df3)

if bus6:
    filtered_df6 = df6[df6['DatabaseName'] == Menu_Choices]
    st.write('Relations: ')
    st.table(filtered_df6)
