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
with Qt4.Objects.Directors;

with UIM.Protocols.Messages;

package body UIM.Protocols.Handlers is

   --  Signals

   -----------------------------------
   --  Emit_Message_Recieve_Signal  --
   -----------------------------------
   procedure Emit_Message_Recieve_Signal
     (Self : not null access Protocol_Handler;
      Msg  : Qt4.Variants.Q_Variant)
      is separate;

   --------------------------------
   --  Emit_Message_Sent_Signal  --
   --------------------------------
   procedure Emit_Message_Sent_Signal
     (Self : not null access Protocol_Handler;
      Msg  : Qt4.Variants.Q_Variant)
        is separate;

   ----------------------------------
   --  Emit_Message_Typing_Signal  --
   ----------------------------------

   procedure Emit_Message_Typing_Signal
     (Self : not null access Protocol_Handler;
      User : Qt4.Variants.Q_Variant)
        is separate;

   -------------------------------------
   --  Emit_User_Info_Recived_Signal  --
   -------------------------------------
   --  procedure Emit_User_Info_Recived_Signal
   --    (Self : not null access Protocol_Glue;
   --     Info : Qt4.Variants.Q_Variant)
   --       is separate;

   ---------------------------------------
   --  Emit_User_Status_Changed_Signal  --
   ---------------------------------------
   --  procedure Emit_User_Status_Changed_Signal
   --    (Self : not null access Protocol_Glue;
   --     User : Qt4.Variants.Q_Variant)
   --       is separate;

   --  End of signals

   --------------
   --  Create  --
   --------------
   function Create return not null Protocol_Handler_Access is
      Self : constant Protocol_Handler_Access := new Protocol_Handler;

   begin
      Qt4.Objects.Directors.Constructors.Initialize (Self);
      return Self;
   end Create;

   ------------------------------
   --  Message_Recieve_Signal  --
   ------------------------------
   procedure Message_Recieve_Signal
     (Self : not null access Protocol_Handler;
      Msg  : not null UIM.Protocols.Messages.Message_Access)
   is
   begin
      Self.Emit_Message_Recieve_Signal
        (UIM.Protocols.Messages.Message_Variant.Create (Msg));
   end Message_Recieve_Signal;

   ------------------------------
   --  Message_Sent_Signal  --
   ------------------------------
   procedure Message_Sent_Signal
     (Self : not null access Protocol_Handler;
      Msg  : not null UIM.Protocols.Messages.Message_Access)
   is
   begin
      Self.Emit_Message_Sent_Signal
        (UIM.Protocols.Messages.Message_Variant.Create (Msg));
   end Message_Sent_Signal;

   -----------------------------
   --  Message_Typing_Signal  --
   -----------------------------
   procedure Message_Typing_Signal
     (Self : not null access Protocol_Handler;
      User : not null UIM.Protocols.Users.User_Access)
   is
   begin
      Self.Emit_Message_Typing_Signal
        (UIM.Protocols.Users.User_Variant.Create (User));
   end Message_Typing_Signal;

   --  --------------------------------
   --  --  User_Info_Recived_Signal  --
   --  --------------------------------
   --  procedure User_Info_Recived_Signal
   --    (Self : not null access Protocol_Handler;
   --     Info : not null UIM.Protocols.User_Infos.User_Info_Access)
   --  is
   --  begin
   --     Self.Emit_User_Info_Recived_Signal
   --       (UIM.Protocols.User_Infos.User_Info_Variant.Create (Info));
   --  end User_Info_Recived_Signal;

   --  ----------------------------------
   --  --  User_Status_Changed_Signal  --
   --  ----------------------------------
   --  procedure User_Status_Changed_Signal
   --    (Self : not null access Protocol_Handler;
   --     User : not null UIM.Protocols.Users.User_Access)
   --  is
   --  begin
   --     Self.Emit_User_Status_Changed_Signal
   --       (UIM.Protocols.Users.User_Variant.Create (User));
   --  end User_Status_Changed_Signal;

end UIM.Protocols.Handlers;
