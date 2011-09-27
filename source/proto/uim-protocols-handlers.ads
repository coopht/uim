------------------------------------------------------------------------------
--                                                                          --
--                               UIM Project                                --
--                                                                          --
--                Multi protocol instant messenger for unix                 --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Alexander Basov <coopht@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Alexander Basov, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Qt4.Objects;
private with Qt4.Objects.Directors;
with Qt4.Variants;

package UIM.Protocols.Handlers is

   type Protocol_Handler is limited new Qt4.Objects.Q_Object with private;

   type Protocol_Handler_Access is access all Protocol_Handler;

   function Create return not null Protocol_Handler_Access;

private

   type Protocol_Handler is limited new Qt4.Objects.Directors.Q_Object_Director
     with null record;

   --  Qt Signals --

   --  Signals notify gui about some events
   --  for internal use only

   --  Message group

   procedure Emit_Message_Recieve_Signal
     (Self : not null access Protocol_Handler;
      Msg  : Qt4.Variants.Q_Variant);
   pragma Q_Signal (Emit_Message_Recieve_Signal);
   --  Signal emits when new message arrives from somebody

   --  procedure Emit_Typing_Notification_Signal
   --    (Self : not null access Protocol_Handler;
   --     User : Qt4.Variants.Q_Variant);
   --  pragma Q_Signal (Emit_Typing_Notification_Signal);
   --  Signal emits typing notification

   procedure Emit_Message_Sent_Signal
     (Self : not null access Protocol_Handler;
      Msg  : Qt4.Variants.Q_Variant);
   pragma Q_Signal (Emit_Message_Sent_Signal);
   --  Signal emits message sent to somebody
   --  end of message group

   --  Roster management group

   --  procedure Emit_User_Info_Recived_Signal
   --    (Self : not null access Protocol_Handler;
   --     Info : Qt4.Variants.Q_Variant);
   --  pragma Q_Signal (Emit_User_Info_Recived_Signal);
   --  --  Signal emits, when user info arrived

   --  procedure Emit_User_Status_Changed_Signal
   --    (Self : not null access Protocol_Handler;
   --     User : Qt4.Variants.Q_Variant);
   --  pragma Q_Signal (Emit_User_Status_Changed_Signal);
   --  --  Signal Emits, when status changed of some user

   --  End of Roster management group
end UIM.Protocols.Handlers;
