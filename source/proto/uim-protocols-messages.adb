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

package body UIM.Protocols.Messages is

   --------------------
   --  Get_Adressee  --
   --------------------
   function Get_Adressee (Self : Message)
      return League.Strings.Universal_String is
   begin
      return Self.Adressee;
   end Get_Adressee;

   ----------------
   --  Get_Body  --
   ----------------
   function Get_Body (Self : Message)
      return League.Strings.Universal_String is
   begin
      return Self.The_Body;
   end Get_Body;

   ------------------
   --  Get_Sender  --
   ------------------
   function Get_Sender (Self : Message)
      return League.Strings.Universal_String is
   begin
      return Self.Sender;
   end Get_Sender;

   -----------------
   --  Get_Topic  --
   -----------------
   function Get_Topic (Self : Message)
      return League.Strings.Universal_String is
   begin
      return Self.Topic;
   end Get_Topic;

   --------------------
   --  Set_Adressee  --
   --------------------
   procedure Set_Adressee (Self     : in out Message;
                           Adressee : League.Strings.Universal_String) is
   begin
      Self.Adressee := Adressee;
   end Set_Adressee;

   ----------------
   --  Set_Body  --
   ----------------

   procedure Set_Body (Self     : in out Message;
                       The_Body : League.Strings.Universal_String) is
   begin
      Self.The_Body := The_Body;
   end Set_Body;

   ------------------
   --  Set_Sender  --
   ------------------
   procedure Set_Sender (Self   : in out Message;
                         Sender : League.Strings.Universal_String) is
   begin
      Self.Sender := Sender;
   end Set_Sender;

   -----------------
   --  Set_Topic  --
   -----------------
   procedure Set_Topic (Self  : in out Message;
                        Topic : League.Strings.Universal_String) is
   begin
      Self.Topic := Topic;
   end Set_Topic;

end UIM.Protocols.Messages;
