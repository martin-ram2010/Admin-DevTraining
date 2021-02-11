/*
SampleClass c1 = new SampleClass();
SampleClass c2 = new SampleClass();
*/
public class SampleClass {
    //Static variable
    public static String staticMessage = 'Static variable';
    //Constant 
    public static final Double PI_VALUE ;//= 3.14;
    //Instance Variable
    public String instanceMessage = 'Instance variable';
    
    //Static method
    public static void printStaticData(){
        System.debug('staticMessage:'+staticMessage);
        System.debug('PI_VALUE:'+PI_VALUE);
    }

    //Instance Method
    public void printInstanceData(){
        System.debug('instanceMessage:'+instanceMessage);
    }

    //Constructor - Object
    public SampleClass(){
        System.debug('Constructor ---Init-instanceMessage,staticMessage----3');
        
        //Constants - Static Final members can only be assigned in their declaration, static blocks
        //PI_VALUE = 3.14159;
        
        //Static variables can be initialized in the Constructor
        staticMessage ='Static variable - initailed in Constructor';
        
        //Instance variables can be initialized in the Constructor
        instanceMessage = 'Instance variable - initailed in Constructor';
        
        SampleClass.printStaticData();
        this.printInstanceData();
    }
    
    //Initialization Block - Object
    {
        System.debug('Initialization Block --Init-instanceMessage,staticMessage -----2');
        
        //Instance variables can be initialized in the Constructor
        instanceMessage = 'Instance variable - initailed in Initialization Block';
        
        //Static variables can be initialized in the Initialization Block
        staticMessage ='Static variable - initailed in Initialization Initialization Block';
        
        //Constants - Static Final members can only be assigned in their declaration, static blocks
        //PI_VALUE = 3.14159;
        
        SampleClass.printStaticData();
        this.printInstanceData();
    }
    
    //Static Initialization Block
    static{//Assign Static Constants and Static variables
        System.debug('Static Initialization Block -Init-- staticMessage,PI_VALUE -------1');
        
        //Static variables and Constants can be initialized in the static Initialization Block
        staticMessage ='Static variable - initailed in Static Initialization Block';
        PI_VALUE = 3.14;
        
        //Instance variables - won't be available in static Initiation context
        //instanceMessage = 'Instance variable - initailed in Static Initialization Block';
        
        SampleClass.printStaticData();
    }
}