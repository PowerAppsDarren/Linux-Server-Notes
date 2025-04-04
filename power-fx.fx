```powerfx

    LOWEST_ID_IN_CHUNK = First(DATA_SOURCE).ID
    HIGHEST_ID_IN_CHUNK = Last(DATA_SOURCE).ID

    ClearCollect(
        ALL_OUR_CHUNKS_COLLECTION, 
        
    );

    
    ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
    We're going to need a collection to hold the data from each iteration.
    So that we can go back 1 row to get the last values. 
    ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
    ClearCollect(
        OUR_LOOP_COLLECTION, 
        [
            LOWEST_ID_IN_CHUNK          = First(DATA_SOURCE).ID                         // ID=2              
            HIGHEST_ID_IN_CHUNK         = Last(DATA_SOURCE).ID                          // ID=2001  
            LOWEST_CREATED_IN_CHUNK     = First(DATA_SOURCE).Created (date/time)        // 3/28/2025 12:36 PM
            HIGHEST_CREATED_IN_CHUNK    = Last(DATA_SOURCE).Created (date/time)         // 3/28/2025 3:38 PM
        ]
    ); 

    For Each() // literation - ForAll() in Pfx
        Chunk_Number = 1, ...5 As my, 

        // ================================================================
        //
        // Inside the loop we'll execute for each iteration!
        //
        // ================================================================
        /*
            This IF is responsible for getting the following values: 
                LOWEST_ID_IN_CHUNK, 
                HIGHEST_ID_IN_CHUNK, 
                LOWEST_CREATED_IN_CHUNK, 
                HIGHEST_CREATED_IN_CHUNK

            ...so that we can use them in the Collect() function below.

        */




        If(
            // ================================================================
            //
            // boolean critera - if value
            // If this is the very first iteration, then we want to get the first chunk of data
            //
            // ================================================================
            (iteration # - my.Value) = 1,   
            // ================================================================
            //
            // TRUE or THEN part
            // JUST THE FIRST ITERATION
            // 
            // ================================================================
            LOWEST_ID_IN_CHUNK          = First(DATA_SOURCE).ID                         // ID=2              
            HIGHEST_ID_IN_CHUNK         = Last(DATA_SOURCE).ID                          // ID=2001  
            LOWEST_CREATED_IN_CHUNK     = First(DATA_SOURCE).Created (date/time)        // 3/28/2025 12:36 PM
            HIGHEST_CREATED_IN_CHUNK    = Last(DATA_SOURCE).Created (date/time)         // 3/28/2025 3:38 PM
            , 


            // ================================================================
            //
            // FALSE or ELSE part
            // ALL OTHER ITERATIONS PAST THE FIRST
            //
            // ================================================================
            LOWEST_ID_IN_CHUNK          =   Lookup(
                                                DATA_SOURCE, 
                                                Created > HIGHEST_CREATED_IN_CHUNK (highest created, from the last iteration), 
                                                ID
                                            )
            HIGHEST_ID_IN_CHUNK         =   Last(
                                                Filter(
                                                    DATA_SOURCE, 
                                                    Created > HIGHEST_CREATED_IN_CHUNK (highest created, from the last iteration)
                                                )
                                            ).ID
            LOWEST_CREATED_IN_CHUNK     =   Lookup(
                                                DATA_SOURCE, 
                                                Created > HIGHEST_CREATED_IN_CHUNK (highest created, from the last iteration), 
                                                ID
                                            )
            HIGHEST_CREATED_IN_CHUNK    = Last(DATA_SOURCE).Created (date/time)
        );

            //
            // Get the HIGHEST ID
            // in the next iteration's chunk
            // for the next iteration
            // 
            LOWEST_ID_IN_CHUNK = 
                Lookup(
                    DATA_SOURCE, 
                    Created > HIGHEST_CREATED_IN_CHUNK (highest created from the last chunk), 
                    ID
                )

            HIGHEST_CREATED_IN_CHUNK = Lookup(                    
                ALL_OUR_CHUNKS_COLLECTION, 
                ID = HIGHEST_ID_IN_CHUNK, 
                Created (date/time)
            )
        )
        //
        // Inside the loop we'll execute for each iteration... BOTH FIRST AND the other iterations
        //
        // 
        Collect(
            ALL_OUR_CHUNKS_COLLECTION, 
            Filter(
                DATA_SOURCE,  
                Created >= LOWEST_CREATED_IN_CHUNK
                AND 
                Created <= HIGHEST_CREATED_IN_CHUNK
            )
        )


        //
        // But first, go get the HIGHEST created 
        // date/time in the current iteration's chunk
        // 
        HIGHEST_CREATED_IN_CHUNK =
            Lookup(                    
                DATA_SOURCE, 
                ID = HIGHEST_ID_IN_CHUNK, 
                Created (date/time)
            )


            
            //
            // Get the HIGHEST ID
            // in the next iteration's chunk
            // for the next iteration
            // 
            LOWEST_ID_IN_CHUNK = 
                Lookup(
                    DATA_SOURCE, 
                    Created > HIGHEST_CREATED_IN_CHUNK (highest created from the last chunk), 
                    ID
                )

            //
            // Get the HIGHEST ID
            // for the next chunk 
            // for the next iteration
            // 
            HIGHEST_ID_IN_CHUNK = 
                Lookup(
                    // 1st param
                    DATA_SOURCE, 
                    // 2nd param
                    ID = Last(
                                Filter(
                                    DATA_SOURCE, 
                                    Created > HIGHEST_CREATED_IN_CHUNK, 
                                )
                        ).ID,
                    // 3rd param
                    ID             
                ),
            //
            // false or Else block
            // 
            
        )






    LOWEST_ID_IN_CHUNK = First(DATA_SOURCE).ID
    HIGHEST_ID_IN_CHUNK = Last(DATA_SOURCE).ID



    Filter(
        DATA_SOURCE,
        ID >= LOWEST_ID_IN_CHUNK
        &&
        ID <= HIGHEST_ID_IN_CHUNK
    )


            /*
            WITH (
                SKINNY_RESULT_SET = 
                    Filter(
                        DATA_SOURCE, 
                        Created >= LOWEST_CREATED_IN_CHUNK
                        AND 
                        Created <= HIGHEST_CREATED_IN_CHUNK
                    )
            )*/

```