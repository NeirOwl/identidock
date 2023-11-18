import unittest
import identidock

class TestCase(unittest.TestCase):
    def setUp(self):
        identidock.app.config["Testing"] = True
        self.app = identidock.app.test_client()

    def test_get_mainpage(self):
        page = self.app.post("/", data=dict(name="Moby Dick"))
        assert page.status_code == 200
        page = str(page.data, "utf-8")
        assert "Привет" in page
        assert "Moby Dick" in page

    def test_html_escaping(self):
        page = self.app.post("/", data=dict(name='"><b>TEST</b><!--'))
        assert "<b>" not in str(page.data)

if __name__ == "__main__":
    unittest.main()
