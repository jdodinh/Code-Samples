# C Code Samples
### simple_diamond.c:
This program simply prints out a diamond which has a given width specified by the user input. Use gcc to compile, and pass as the argument the height (an odd integer) of the diamond you would like to see:
Example:
gcc simple_diamond.c
./a.out 7
```
   *   
  ***  
 ***** 
*******
 ***** 
  ***  
   *   
```
### sierpinski_diamond
This program is similar to the previous one, except two arguments are passed to the program. Firstly the widthe (which must be a power of 2, minus 1), as well as the level of the division of the sierpinski triangle. Here how to conpile withing the teminal:
gcc sierpinski_diamond.c
./a.out 63 4
```
                               *                               
                              ***                              
                             *****                             
                            *******                            
                           *       *                           
                          ***     ***                          
                         *****   *****                         
                        ******* *******                        
                       *               *                       
                      ***             ***                      
                     *****           *****                     
                    *******         *******                    
                   *       *       *       *                   
                  ***     ***     ***     ***                  
                 *****   *****   *****   *****                 
                ******* ******* ******* *******                
               *                               *               
              ***                             ***              
             *****                           *****             
            *******                         *******            
           *       *                       *       *           
          ***     ***                     ***     ***          
         *****   *****                   *****   *****         
        ******* *******                 ******* *******        
       *               *               *               *       
      ***             ***             ***             ***      
     *****           *****           *****           *****     
    *******         *******         *******         *******    
   *       *       *       *       *       *       *       *   
  ***     ***     ***     ***     ***     ***     ***     ***  
 *****   *****   *****   *****   *****   *****   *****   ***** 
******* ******* ******* ******* ******* ******* ******* *******
 *****   *****   *****   *****   *****   *****   *****   ***** 
  ***     ***     ***     ***     ***     ***     ***     ***  
   *       *       *       *       *       *       *       *   
    *******         *******         *******         *******    
     *****           *****           *****           *****     
      ***             ***             ***             ***      
       *               *               *               *       
        ******* *******                 ******* *******        
         *****   *****                   *****   *****         
          ***     ***                     ***     ***          
           *       *                       *       *           
            *******                         *******            
             *****                           *****             
              ***                             ***              
               *                               *               
                ******* ******* ******* *******                
                 *****   *****   *****   *****                 
                  ***     ***     ***     ***                  
                   *       *       *       *                   
                    *******         *******                    
                     *****           *****                     
                      ***             ***                      
                       *               *                       
                        ******* *******                        
                         *****   *****                         
                          ***     ***                          
                           *       *                           
                            *******                            
                             *****                             
                              ***                              
                               *                              
```
