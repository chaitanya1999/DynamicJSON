/*
	@author : Chaitanya Vaishampayan
*/

public class DynamicJSON {
    private Map<String,Object> jsonObj = null;
    private List<Object> jsonArr = null;
    
    //private constructor. use from/new methods.
    private DynamicJSON(){
    }
    
    //parse: Creates DynamicJSON object from Json String.
    public static DynamicJSON parse(String jsonStr){
        System.debug(LoggingLevel.INFO, 'DynamicJSON. JSON from String');
        try {
            Object deserialized = JSON.deserializeUntyped(jsonStr);
            try{
                return new DynamicJSON((Map<String,Object>) deserialized);
            } catch(TypeException tex){
                return new DynamicJSON((List<Object>) deserialized);
            }
        } catch(TypeException tex){
            throw new TypeException('Invalid Format. Given String is neither JSON Object nor JSON Array.');
        }
    }

    //Creates DynamicJSON over empty Json Object.
    public static DynamicJSON newObject(){
        System.debug(LoggingLevel.INFO, 'DynamicJSON. new json object');
        return new DynamicJSON(new Map<String,Object>());
    }

    //Creates DynamicJSON over empty Json array
    public static DynamicJSON newArray(){
        System.debug(LoggingLevel.INFO, 'DynamicJSON. new json object');
        return new DynamicJSON(new List<Object>());
    }

    //used internally
    private DynamicJSON(Map<String,Object> jObj){
        System.debug(LoggingLevel.INFO, 'DynamicJSON. JSON Object');
        this.jsonObj = jObj;
    }

    //used internally
    private DynamicJSON(List<Object> jList){
        System.debug(LoggingLevel.INFO, 'DynamicJSON. JSON Array');
        this.jsonArr = jList;
    }

    //returns True if the DynamicJSON is a JSON Object
    public Boolean isObject(){
        return this.jsonObj != null;
    }
    //returns True is the DynamicJSON is a JSON array
    public Boolean isArray(){
        return this.jsonArr != null;
    }

    /* START - JSON Object methods */
    
    //assigns the specified value object to the given key in Json
    public DynamicJSON put(String key, Object value){
        if(!this.isObject()) {
            System.debug(LoggingLevel.ERROR, 'put(). ' + NOT_JSON_OBJECT_MESSAGE);
        } else {
            if(value instanceof DynamicJSON){
                DynamicJSON dJson = ((DynamicJSON)value);
                Object valueToSet = dJson.isArray() ? (Object)dJson.jsonArr : (Object)dJson.jsonObj;
                this.jsonObj.put(key,valueToSet);
            } else {
                this.jsonObj.put(key,value);
            }
        }
        return this;
    }

    //returns the Integer present at the provided key if the DynamicJSON is a JSON Object
    public Integer getInt(String key){
        if(!this.isObject()) {
            System.debug(LoggingLevel.ERROR, 'getInt(). ' + NOT_JSON_OBJECT_MESSAGE);
            return null;
        } else {
            Integer ret = (Integer)this.jsonObj.get(key);
            return ret;
        }
    }

    //returns the String present at the provided key if the DynamicJSON is a JSON Object
    public String getString(String key){
        if(!this.isObject()) {
            System.debug(LoggingLevel.ERROR, 'getString(). ' + NOT_JSON_OBJECT_MESSAGE);
            return null;
        } else {
            String ret = (String)this.jsonObj.get(key);
            return ret;
        }
    }
    
    //returns the Boolean present at the provided key if the DynamicJSON is a JSON Object
    public Boolean getBoolean(String key){
        if(!this.isObject()) {
            System.debug(LoggingLevel.ERROR, 'getBoolean(). ' + NOT_JSON_OBJECT_MESSAGE);
            return null;
        } else {
            Boolean ret = (Boolean)this.jsonObj.get(key);
            return ret;
        }
    }
    

    //returns the Json object present at the provided key if the DynamicJSON is a JSON Object
    public DynamicJSON getJSONObject(String key){
        if(!this.isObject()) {
            System.debug(LoggingLevel.ERROR, 'getJSONObject(). ' + NOT_JSON_OBJECT_MESSAGE);
            return null;
        } else {
            DynamicJSON ret = null;
            Object obj = this.jsonObj.get(key);
            ret = new DynamicJSON( (Map<String,Object>) obj);
            // try{
            // } catch(Exception ex){
            //     System.debug(LoggingLevel.ERROR, 'getJSONObject(). Cannot convert non json object property to json object.');
            //     ret = null;
            // }
            return ret;
        }
    }

    //returns the Json array present at the provided key if the DynamicJSON is a JSON Object
    public DynamicJSON getJSONArray(String key){
        if(!this.isObject()) {
            System.debug(LoggingLevel.ERROR, 'getJSONArray(). ' + NOT_JSON_OBJECT_MESSAGE);
            return null;
        } else {
            DynamicJSON ret = null;
            Object obj = this.jsonObj.get(key);
            ret = new DynamicJSON( (List<Object>) obj );
            // try{
            // } catch(Exception ex){
            //     System.debug(LoggingLevel.ERROR, 'getJSONObject(). Cannot convert non json array property to json array.');
            //     ret = null;
            // }
            return ret;
        }
    }

    //returns the value at the given key as raw Apex Object type
    public Object get(String key){
        if(!this.isObject()) {
            System.debug(LoggingLevel.ERROR, 'get(string). ' + NOT_JSON_OBJECT_MESSAGE);
            return null;
        } else {
            Object obj = this.jsonObj.get(key);
            return obj;
        }
    }
    /* ENDS - JSON Object methods */



    /* START - JSON Array methods */

    //Sets the value at the provided index if the DynamicJSON is a JSON array
    public DynamicJSON set(Integer index, Object value){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'set(). ' + NOT_JSON_ARRAY_MESSAGE);
        } else {
            Object valueToSet = value;
            if(value instanceof DynamicJSON){
                DynamicJSON dJson = ((DynamicJSON)value);
                valueToSet = dJson.isArray() ? (Object)dJson.jsonArr : (Object)dJson.jsonObj;
            }
            this.jsonArr.set(index, valueToSet);
        }
        return this;
    }

    //Adds the specified value at the end of the array if the DynamicJSON is a JSON array
    public DynamicJSON add(Object value){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'add(). ' + NOT_JSON_ARRAY_MESSAGE);
        } else {
            if(value instanceof DynamicJSON){
                DynamicJSON dJson = ((DynamicJSON)value);
                Object valueToSet = dJson.isArray() ? (Object)dJson.jsonArr : (Object)dJson.jsonObj;
                this.jsonArr.add(valueToSet);
            } else {
                this.jsonArr.add(value);
            }
        }
        return this;
    }

    //returns the Json object present at the provided key if the DynamicJSON is a JSON Array
    public DynamicJSON getJSONObject(Integer index){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getJSONObject(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            DynamicJSON ret = null;
            Object obj = this.jsonArr.get(index);
            ret = new DynamicJSON( (Map<String,Object>) obj);
            // try{
            // } catch(Exception ex){
            //     System.debug(LoggingLevel.ERROR, 'getJSONObject(). Cannot convert non json object element to json object.');
            //     ret = null;
            // }
            return ret;
        }
    }

    //returns the Json array present at the provided key if the DynamicJSON is a JSON Array
    public DynamicJSON getJSONArray(Integer index){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getJSONArray(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            DynamicJSON ret = null;
            Object obj = this.jsonArr.get(index);
            ret = new DynamicJSON( (List<Object>) obj );
            return ret;
        }
    }

    //returns the value at the given index as raw Apex Object type
    public Object get(Integer index){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getJSONObject(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            Object obj = this.jsonArr.get(index);
            return obj;
        }
    }

    //returns the Integer present at the provided key if the DynamicJSON is a JSON Array
    public Integer getInt(Integer index){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getInt(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            Integer ret = (Integer) this.jsonArr.get(index);
            return ret;
        }
    }

    //returns the Integer present at the provided key if the DynamicJSON is a JSON Array
    public String getString(Integer index){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getString(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            String ret = (String) this.jsonArr.get(index);
            return ret;
        }
    }


    //returns the Integer present at the provided key if the DynamicJSON is a JSON Array
    public Boolean getBoolean(Integer index){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getBoolean(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            Boolean ret = (Boolean) this.jsonArr.get(index);
            return ret;
        }
    }

    public List<Object> getAsList(){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getAsList(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            List<Object> ret = this.jsonArr.clone();
            return ret;
        }
    }

    public List<Integer> getAsIntList(){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getAsIntList(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            List<Integer> intList = new List<Integer>();
            for(Object x : this.jsonArr){
                intList.add((Integer) x);
            }
            return intList;
        }
    }

    public List<String> getAsStringList(){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getAsStringList(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            List<String> stringList = new List<String>();
            for(Object x : this.jsonArr){
                stringList.add((String) x);
            }
            return stringList;
        }
    }

    public List<Boolean> getAsBooleanList(){
        if(!this.isArray()){
            System.debug(LoggingLevel.ERROR, 'getAsBooleanList(). ' + NOT_JSON_ARRAY_MESSAGE);
            return null;
        } else {
            List<Boolean> booleanList = new List<Boolean>();
            for(Object x : this.jsonArr){
                booleanList.add((Boolean) x);
            }
            return booleanList;
        }
    }

    
    /* ENDS - JSON Object methods */

    //returns size of array/object(key count)
    public Integer size(){
        if(this.isArray()){
            return this.jsonArr.size();
        } else {
            return this.jsonObj.size();
        }
    }

    //prints the DynamicJSON as formatted serialized string , with some pre text printed before 
    public DynamicJSON printPretty(String preText){
        System.debug(preText + JSON.serializePretty( this.isArray() ? (Object)this.jsonArr : (Object)this.jsonObj ));
        return this;
    }

    //prints the DynamicJSON as formatted serialized string
    public DynamicJSON printPretty(){
        this.printPretty('');
        return this;
    }

    //returns the string-serialized form of the DynamicJSON
    public String stringify(Boolean pretty){
        if(this.isArray()){
            return pretty ? JSON.serializePretty(this.jsonArr) : JSON.serialize(this.jsonArr);
        } else {
            return pretty ? JSON.serializePretty(this.jsonObj) : JSON.serialize(this.jsonObj);
        }
    }

    private static final String NOT_JSON_OBJECT_MESSAGE = 'Cannot call JSON Object method on non-JSON-object entity.';
    private static final String NOT_JSON_ARRAY_MESSAGE = 'Cannot call JSON Array method on non-JSON-array entity.';
}
