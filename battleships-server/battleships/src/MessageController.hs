module MessageController(firstMessage, appendMessage, appendLostMessage) where
    import Structures    
    
    firstMessage :: (String, String) -> Message
    firstMessage crd = NewMessage {coord= Just crd, result=Nothing, prev=Nothing}

    appendMessage :: (String, String) -> Bool-> Message -> Message
    appendMessage crd hit prev = NewMessage {coord= Just crd, result= Just hit, prev= Just prev}

    appendLostMessage :: Bool-> Message -> Message
    appendLostMessage hit prev = NewMessage {coord= Nothing, result= Just hit, prev= Just prev}
