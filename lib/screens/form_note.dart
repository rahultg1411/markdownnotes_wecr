import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdownnotes_wecr/dbs/sql_helper.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class FormNote extends StatelessWidget {
  final dynamic id;
  final dynamic title;
  final dynamic description;

  const FormNote({
    Key? key,
    this.id,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    if (id != null) {
      titleController.text = title;
      descriptionController.text = description;
    }

    // Insert a new note to the database
    Future<void> addItem() async {
      await SQLHelper.createItem(
        titleController.text,
        descriptionController.text,
      );
    }

    // Update an existing note
    Future<void> updateItem(int id) async {
      await SQLHelper.updateItem(
        id,
        titleController.text,
        descriptionController.text,
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          id == null ? 'Add Notes' : 'Edit Notes',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 21,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 80,
        ),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white54,
                ),
              ),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Description',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white54,
                  ),
                ),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (id == null) {
                  await addItem();
                } else {
                  await updateItem(id);
                }

                titleController.text = '';
                descriptionController.text = '';

                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 10,
                  bottom: 10,
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                id == null ? 'Save Note' : 'Update Note',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
