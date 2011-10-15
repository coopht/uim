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
with Qt_Ada.Generic_Variants;
with League.Strings;

with UIM.Protocols.Users;

package UIM.Protocols.Messages is

   type Message is tagged private;

   type Message_Access is access all Message;

   procedure Set_Adressee (Self     : in out Message;
                           Adressee : UIM.Protocols.Users.User_Access);
   --  Sets destination address of the message

   procedure Set_Body (Self     : in out Message;
                       The_Body : League.Strings.Universal_String);
   --  Sets message body

   procedure Set_Sender (Self   : in out Message;
                         Sender : UIM.Protocols.Users.User_Access);
   --  Sets sender of message

   procedure Set_Topic (Self  : in out Message;
                        Topic : League.Strings.Universal_String);
   --  Sets message topic

   function Get_Adressee (Self : Message)
      return UIM.Protocols.Users.User_Access;
   --  Returns destination address of the message

   function Get_Body (Self : Message)
      return League.Strings.Universal_String;
   --  Returns message body

   function Get_Sender (Self : Message)
      return UIM.Protocols.Users.User_Access;
   --  Sets sender of message

   function Get_Topic (Self : Message)
      return League.Strings.Universal_String;
   --  Returns message topic

   package Message_Variant is
      new Qt_Ada.Generic_Variants (Message_Access, "Message_Access");

private

   type Message is tagged record
      Sender   : UIM.Protocols.Users.User_Access;
      Adressee : UIM.Protocols.Users.User_Access;
      The_Body : League.Strings.Universal_String;
      Topic    : League.Strings.Universal_String;
   end record;

end UIM.Protocols.Messages;
