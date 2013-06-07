-- @dialog_handle is of type uniqueidentifier and
-- contains a valid conversation handle.

BEGIN CONVERSATION TIMER (@dialog_handle)
TIMEOUT = 120 ;
