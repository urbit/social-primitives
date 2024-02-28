|%
+$  name    @t
+$  order   @ud
+$  person  [ship nick=name]
+$  bio     [status nick=name]
+$  lis     (list person)
+$  status  
    $%  %invited 
        %accepted
        %admin  ::few admin in guild
    ==
+$  action
    $%  [%new-list =name]
        [%del-list =name]
        [%add-to-list =name =order =person]
        ::del by index 
        [%del-from-list =name =person]
        [%new-order =name =order =person]
        [%new-guild =name]
        [%send-invite =name =ship nick=name]
        [%get-invite =name from=ship]
        [%accept-invite =name from=ship]
    ==
+$  update
    $%  [%new-list =name]
        [%del-list =name]
        [%update-list =name =lis]
        [%gil-info =name gil=(map ship bio)]
    ==
+$  scry
    $%  [%lists (list @t)]
        [%lis lis=(list person)]
    ==
--