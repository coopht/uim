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
with Ada.Tags;
with Ada.Wide_Wide_Text_IO;
with Ada.Characters.Conversions;

package body UIM.Utils.Logger is

   -----------
   --  Log  --
   -----------
   procedure Log (Self        : in out UIM_Logger'Class;
                  Log_Message : Wide_Wide_String) is
   begin
      if Self.Logger_Name.Is_Empty then
         Self.Logger_Name := League.Strings.To_Universal_String
                              (Ada.Characters.Conversions.To_Wide_Wide_String
                                (Ada.Tags.External_Tag (Self'Tag)));
      end if;

      Ada.Wide_Wide_Text_IO.Put_Line
        ("UIM." & Self.Logger_Name.To_Wide_Wide_String
           & " : " & Log_Message);
   end Log;

   -----------
   --  Log  --
   -----------
   procedure Log (Self        : in out UIM_Logger'Class;
                  Log_Message : League.Strings.Universal_String) is
   begin
      if Self.Logger_Name.Is_Empty then
         Self.Logger_Name := League.Strings.To_Universal_String
                              (Ada.Characters.Conversions.To_Wide_Wide_String
                                (Ada.Tags.External_Tag (Self'Tag)));
      end if;

      Ada.Wide_Wide_Text_IO.Put_Line
        ("UIM." & Self.Logger_Name.To_Wide_Wide_String
           & " : " & Log_Message.To_Wide_Wide_String);
   end Log;

   -----------------------
   --  Set_Logger_Name  --
   -----------------------
   procedure Set_Logger_Name (Self        : in out UIM_Logger;
                              Logger_Name : Wide_Wide_String) is
   begin
      Self.Logger_Name := League.Strings.To_Universal_String (Logger_Name);
   end Set_Logger_Name;

   -----------------------
   --  Set_Logger_Name  --
   -----------------------
   procedure Set_Logger_Name (Self        : in out UIM_Logger;
                              Logger_Name : League.Strings.Universal_String) is
   begin
      Self.Logger_Name := Logger_Name;
   end Set_Logger_Name;

end UIM.Utils.Logger;
